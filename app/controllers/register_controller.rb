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

  #上传维保相关的一些图片
  def upload_img
    filename = save_img(params[:photo])
    imageturn(filename)
    if filename
      thumb = "#{File::dirname(filename)}/#{File::basename(filename).gsub(File::extname(filename),"")}-thumb#{File::extname(filename)}"
      image = MiniMagick::Image.open(filename)
      image.resize "360x360"
      image.write thumb
    end
    render json: {code:0,url:filename.gsub("#{Rails.root}/public",""),thumb:thumb.gsub("#{Rails.root}/public","")}
  end

  #保存图片
  def save_img(file)
    dir_path = "#{Rails.root}/public/images"
    if !File.exist?(dir_path)
      FileUtils.makedirs(dir_path)
    end
    file_rename = "#{Digest::MD5.hexdigest(Time.now.to_s)}#{File.extname(file.original_filename)}"
    file_path = "#{dir_path}/#{file_rename}"
    File.open(file_path,'wb+') do |item| #用二进制对文件进行写入
      item.write(file.read)
    end
    file_path
  end

  def imageturn(filename)
    image = MiniMagick::Image.open(filename)
    if image.data["orientation"] == "RightTop"
      #image.rotate "90"
      #image.data["orientation"] = "Undefined"
      image.auto_orient
      image.write filename
    end
  end

  def crop_img(thumb, photo)
    if File::file?(thumb) && File::file?(photo)
      thumb_width = MiniMagick::Image.open(thumb).width
      thumb_height = MiniMagick::Image.open(thumb).height
      width = MiniMagick::Image.open(photo).width
      height = MiniMagick::Image.open(photo).height
      ratio = width/thumb_width.to_f
      x = yk_user(:cropx).to_i * ratio
      y = yk_user(:cropy).to_i * ratio
      w = yk_user(:cropw).to_i * ratio
      h = yk_user(:croph).to_i * ratio
      temp_img = MiniMagick::Image.open(photo)
      temp_img.crop "#{w}x#{h}+#{x}+#{y}"
      temp_img.resize "512x512"
      temp_img.write thumb
    end
  end

  private
    def check_params
      if params[:post].present? && params[:post][:username].present? && params[:post][:phone].present? && params[:post][:photo].present? && params[:post][:cropx].present? && params[:post][:cropy].present? && params[:post][:cropw].present? && params[:post][:croph].present?
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
