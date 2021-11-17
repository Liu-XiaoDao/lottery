class InventoriesController < ApplicationController
  layout 'template'

  def index
    @inventories = Inventory.all.paginate page: params[:page], per_page: 50
  end

  def research_index

  end

  def research
    @inventories = ActiveRecord::Base.connection.execute("SELECT `inventories`.abid, `inventories`.size, `inventories`.unit, `inventories`.fridge, count(*) FROM `inventories` WHERE abid = '#{params[:post][:abid]}' GROUP BY size, fridge")
  end

  def upload
    if !params[:files][0]
      redirect_to :inventories, alert: "You need select a file"
    else

      file = params[:files][0]
      # 保存的文件名
      save_file_name = "#{Time.now.strftime("%Y_%m_%d_%H_%M_%S")}_#{file.original_filename}"
      File.open("#{Rails.root}/public/uploads/#{save_file_name}", "wb") do |f|
          f.write(file.read)
      end

      system("/usr/bin/python3 /var/www/inventory_xl.py #{Rails.root}/public/uploads/#{save_file_name}")

      redirect_to inventories_url
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
