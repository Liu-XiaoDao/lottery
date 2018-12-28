class SigninController < ApplicationController
  layout 'template'
  def index
  end

  def create
    if check_phone(params[:post][:phone])
      @user = User.find_by_phone params[:post][:phone]
      @user.is_active = 1
      if @user.save
        # ActionCable.server.broadcast 'signin', message: {user_info: @user, signin_count: User.signin_count}
        redirect_to "/welcome?active=1&_id=#{@user.id}"
      else
        '没有找到此用户'
        redirect_to signin_index_url
      end
    else
      '没有找到此用户'
      redirect_to signin_index_url
    end
  end

  private
    def check_phone(phone)
      count = User.where(phone: phone).count
      return count == 1
    end
end
