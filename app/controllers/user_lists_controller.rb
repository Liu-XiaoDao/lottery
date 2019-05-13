class UserListsController < ApplicationController
  layout 'template'

  def index
    @user_lists = UserList.all.paginate page: params[:page], per_page: 18
  end

  def leader_index()
  end

  def create
    @user_list = UserList.new(params.require(:user_list).permit(:name))
    if @user_list.save
      flash["success"] = "添加成功"
    else
      flash["danger"] = "添加失败"
    end
    redirect_to user_lists_url
  end

  def edit
    @user_list = UserList.find params[:id]
  end

  def update
    @user_list = UserList.find params[:id]
    if @user_list.update_attributes(params.require(:user_list).permit(:name))
      flash["success"] = "添加成功"
    else
      flash["danger"] = "添加失败"
    end
    redirect_to user_lists_url
  end

  def upload
    # binding.pry
    if !params[:files][0]
      redirect_to :user_lists, alert: "You need select a file"
    else
      @user_lists = UserList.import_preview(params[:files][0])
      @user_lists_cache_key = "user_lists#{SecureRandom.hex}"
      Rails.cache.write(@user_lists_cache_key, @user_lists, expires_in: 1.days)
      return render plain: @user_lists_cache_key
    end
  end

  def import_preview
    @user_lists_cache_key = params[:cache_key]
    @user_lists = Rails.cache.read(params[:cache_key])
  end

  def import
    cr, er = 0, 0
    @user_lists = Rails.cache.read(params[:cache_key])
    @user_lists.map do |t|
      t.save ? cr += 1 : er += 1
    end
    Rails.cache.delete(params[:cache_key])
    info = (er == 0) ? :success : :danger
    flash[info] = "create: " + cr.to_s  + " error: " + er.to_s
    redirect_to user_lists_url
  end

  def destroy
    @user_list = UserList.find(params[:id])
    @user_list.destroy
    flash[:success] = "删除成功"
    redirect_to user_lists_path
  end
end
