class RegisterController < ApplicationController
  layout 'template'
  before_action :check_params, only: [:create]

  def index
    @user = User.new
  end

  def create
    if check_phone(yk_user(:phone)) && check_user(yk_user(:username))
      create_user
      redirect_to welcome_index_url(_id: @user.id)
    else
      redirect_to register_index_url
    end

   end

   def create_user
     @user = User.new
     @user.name = params[:post][:username]
     @user.phone = params[:post][:phone]
     @user.user_list = UserList.find_by_name params[:post][:username]
     if @user.save
       families = params[:post][:families]
       families.each do |people|
         if people[:name].present?
           @user.families.create(name: people[:name], family_type: people[:type])
         end
       end
     end

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
