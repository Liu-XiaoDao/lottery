class InventoriesController < ApplicationController
  layout 'template'

  def index
    @inventories = Inventory.all.paginate page: params[:page], per_page: 50
  end

  def upload
    if !params[:files][0]
      redirect_to :inventories, alert: "You need select a file"
    else
      @inventories = Inventory.import_preview(params[:files][0])
      @inventories_cache_key = "inventories#{SecureRandom.hex}"
      Rails.cache.write(@inventories_cache_key, @inventories, expires_in: 1.days)
      return render plain: @inventories_cache_key
    end
  end

  def import_preview
    @inventories_cache_key = params[:cache_key]
    @inventories = Rails.cache.read(params[:cache_key])
  end

  def import
    cr, er = 0, 0
    @inventories = Rails.cache.read(params[:cache_key])
    @inventories.map do |t|
      t.save ? cr += 1 : er += 1
    end
    Rails.cache.delete(params[:cache_key])
    info = (er == 0) ? :success : :danger
    flash[info] = "create: " + cr.to_s  + " error: " + er.to_s
    redirect_to inventories_url
  end
end
