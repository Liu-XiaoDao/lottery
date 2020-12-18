class UsersController < ApplicationController
  layout 'template'
  http_basic_authenticate_with name: "yk_labour_union", password: "YKgonghui!123?", except: :research

  def index
    @users = User.all.paginate page: params[:page], per_page: 18
  end

  def admin_create
    @user = User.new
    @user.name = params[:user][:username]
    @user.attendance = params[:user][:attendance]
    @user.avatar_url = "/default_avatar-thumb.jpg"
    @user.pre = params[:user][:pre]
    @user.phone = params[:user][:phone]
    @user.year =  Date.today.year
    @user.is_active = 1
    @user.save
    if @user.save
      flash["success"] = "添加成功"
    else
      flash["danger"] = "添加失败"
    end
    redirect_to users_url
  end

  def delete
    @user = User.find params[:id]
    @user.destroy
    redirect_to users_path
  end

  def active
    @user = User.find params[:id]
    @user.is_active = 1
    @user.save
    redirect_to users_path
  end

  def reset
    User.update_all(lottery:nil)
    redirect_to users_url
  end

  def research
    @user = User.find_by_name_and_id(params[:post][:username],params[:post][:user_id])
  end

  def json_users
    @users = User.where(is_active: true)
    render json: {info:@users}
  end

  def lottery
    @user = User.find_by_phone params[:phone]
    @user.lottery = params[:lottery]
    @user.save
    render json: {code: 1,info: ''}
  end
end
