class RegisterController < ApplicationController
  layout 'template'
  before_action :check_params, only: [:create]
  before_action :check_attenance, only: [:create]

  def index
    @user = User.new
  end

  def research_index

  end

  def create
    if check_user(yk_user(:username))
      create_user
      redirect_to welcome_index_url(_id: @user.id)
    else
      redirect_to register_index_url
    end

  end

  def create_user
    @user = User.new
    @user.name = params[:post][:username]
    @user.is_attendance = params[:post][:is_attendance]
    @user.is_car = params[:post][:is_car]
    @user.is_lunch = params[:post][:is_lunch]
    @user.id_number = params[:post][:id_number]
    @user.phone = params[:post][:phone]
    @user.notes = params[:post][:notes]
    @user.user_list = UserList.find_by_name params[:post][:username]
    @user.save

    families = params[:post][:families]
    if families.present?
      families.each do |people|
        if people[:name].present?
          @user.families.create(name: people[:name], family_type: people[:type], id_number: people[:id_number], height: people[:height])
        end
      end
    end
  end

  private
    def check_params
      if params[:post].present? && params[:post][:username].present?
        return true
      else
        flash["danger"] = "参数缺失，注册失败"
        redirect_to register_index_url
      end
    end

    def check_attenance
      if params[:post].blank? || params[:post][:is_car].blank?
        flash["danger"] = "参数缺失，注册失败"
        redirect_to register_index_url
      elsif params[:post][:is_car] == "有事不能参加, 很遗憾T_T"
        return true
      else
        if User.where(is_car: params[:post][:is_car]).count >= 1800
          flash["danger"] = "剩余座席不足，注册失败"
          redirect_to register_index_url
        else
          return true
        end
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

      if User.find_by_name(username).present?
        flash["danger"] = "该员工#{username}已登记,请勿重复操作！"
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
