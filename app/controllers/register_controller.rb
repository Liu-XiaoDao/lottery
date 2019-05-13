class RegisterController < ApplicationController
  layout 'template'
  before_action :check_params, only: [:create]

  def index
    @user = User.new
  end

  def create
    if check_phone(yk_user(:phone)) && check_user(yk_user(:username))
      thumb = "#{Rails.root}/public#{yk_user(:photo)}"
      photo ="#{File::dirname(thumb)}/#{File::basename(thumb).gsub('-thumb','')}"
      crop_img(thumb, photo)
      create_user
      redirect_to welcome_index_url(_id: @user.id)
    else
      redirect_to register_index_url
    end

   end

   def create_user
     @user = User.new
     @user.name = params[:post][:username]
     @user.avatar_url = params[:post][:photo]
     @user.phone = params[:post][:phone]
     @user.year =  Date.today.year
     @user.is_active = 0
     @user.save
   end

  private
    def check_params
      if params[:post].present? && params[:post][:username].present? && params[:post][:phone].present?
        return true
      else
        flash["danger"] = "参数缺失，注册失败"
        redirect_to register_index_url
      end
    end

    def yk_user(key)
      params[:post][key]
    end

    def check_user(username)
      if UserList.find_by_name(username).blank?
        flash["danger"] = "该员工#{username}不存在！"
        return nil
      end
      return true
    end

    def check_phone(phone)
      if User.find_by_phone(phone).present?
        flash["danger"] = "该电话号码#{phone}已注册！"
        return nil
      end
      return true
    end

end
