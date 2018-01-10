class RegisterController < ApplicationController
	layout 'register'
	def index
		@user = User.new
	end 

	def new
		
	end

	def create
		# @user = User.new
	 #    @user.name = params[:post][:username]
	 #    @user.attendance = params[:post][:attendance]
	 #    @user.avatar_url = params[:post][:photo]
	 #    @user.is_active = 0

100.times do 
	@user = User.new
    @user.name = params[:post][:username]
    @user.attendance = params[:post][:attendance]
    @user.avatar_url = params[:post][:photo]
    @user.is_active = 0
    @user.save
end
	    
	    # if @user.save
	    # 	redirect_to users_path
	    # else
	    # 	render json: @user.errors
	    # end

	    
	end

	#上传维保相关的一些图片
  def upload_img
    imgurl = save_img(params[:photo])
    render json: {code:0,url:imgurl,thumb:imgurl}
  end

  #保存图片
  def save_img(file)
    root_path = "#{Rails.root}/public"
    dir_path = "/images/service/#{Time.now.strftime('%Y%m')}"
    final_path = root_path + dir_path
    if !File.exist?(final_path)
      FileUtils.makedirs(final_path)
    end
    file_rename = "#{Digest::MD5.hexdigest(Time.now.to_s)}#{File.extname(file.original_filename)}"
    file_path = "#{final_path}/#{file_rename}"
    File.open(file_path,'wb+') do |item| #用二进制对文件进行写入
      item.write(file.read)
    end
    "#{dir_path}/#{file_rename}"
  end
end
