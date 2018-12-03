class UsersController < ApplicationController
  layout 'template'  
  def index
    @users = User.all
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
