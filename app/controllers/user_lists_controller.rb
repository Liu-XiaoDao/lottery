class UserListsController < ApplicationController
  layout 'template'

  def index
    @user_lists = UserList.all
  end

  def import_preview
    if !params[:files][0]
      redirect_to :user_lists, alert: "You need select a file"
    else
      @user_lists = UserList.import_preview(params[:files][0])
      @user_lists_cache_key = "user_lists#{SecureRandom.hex}"
      Rails.cache.write(@user_lists_cache_key, @user_lists, expires_in: 1.days)
    end
  end

  def import
    up, cr, er = 0, 0, 0
    @user_lists = Rails.cache.read(params[:user_lists_cache_key])
    @user_lists[:update_record].map do |t|
      t.save ? up += 1 : er += 1
    end
    @user_lists[:create_record].each do |t|
      unless UserList.exists?(id: t.id)
        t.save ? cr += 1 : er += 1
      end
    end
    Rails.cache.delete(params[:user_lists_cache_key])
    info = (er == 0) ? :notice : :alert
    flash[info] = "create: " + cr.to_s + " update: " + up.to_s + " error: " + er.to_s
    redirect_to user_lists_url
  end
end
