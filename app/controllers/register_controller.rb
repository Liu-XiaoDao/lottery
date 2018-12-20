class RegisterController < ApplicationController
  layout 'template'
  def index
    @user = User.new
  end

  def new

  end

  def create
    if check_phone(yk_user(:phone)) && check_attendance(yk_user(:pre),yk_user(:attendance)) && yk_user(:cropw) && yk_user(:croph)

      thumb = "#{Rails.root}/public#{yk_user(:photo)}"
      photo ="#{File::dirname(thumb)}/#{File::basename(thumb).gsub('-thumb','')}"

      crop_img(thumb, photo)
      create_user
      redirect_to welcome_index_url(_id: @user.id)
    end

   end

   def create_user
     @user = User.new
     @user.name = params[:post][:username]
     @user.attendance = params[:post][:attendance]
     @user.avatar_url = params[:post][:photo]
     @user.pre = params[:post][:pre]
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
    def yk_user(key)
      params[:post][key]
    end

    def check_attendance(pre,attendance)
      if User.find_by_pre_and_attendance(pre,attendance)
        raise "该工牌号码#{pre}#{attendance}已被#{user.name}注册！"
      end
      return true
    end

    def check_phone(phone)
      if User.find_by_phone(phone).present?
        raise "该电话号码#{phone}已注册！"
      end
      return true
    end

end
