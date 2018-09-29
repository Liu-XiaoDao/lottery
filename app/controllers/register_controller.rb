class RegisterController < ApplicationController
	layout 'template'
	def index
		@user = User.new
	end

	def new

	end

	def create
	  @user = User.new
    @user.name = params[:post][:username]
    @user.attendance = params[:post][:attendance]
    @user.avatar_url = params[:post][:photo]
    @user.is_active = 0
    @user.save

    "post"=>{"pre"=>"SWN-", "attendance"=>"20170020", "username"=>"dxx", "phone"=>"18106322292", "photo"=>"/images/service/201809/e558cbe7316b3bc782477e5c1e35b568.jpg", "cropx"=>"66", "cropy"=>"153", "cropw"=>"200", "croph"=>"200"}, "photo"=>"425322168076235771.jpg"}

    yk_id = yk_user(:pre) + yk_user(:yk_user)
    if check_phone(yk_user(:phone)) && check_id(yk_id) && yk_user(:username) && yk_user(:photo) && yk_user(:cropw) && yk_user(:croph) && yk_user(:phone)

      thumb = "#{Rails.root}/public#{yk_user(:photo)}"
      photo ="#{File::dirname(thumb)}/#{File::basename(filename).gsub('-thumb','')}"

      if File::file?(thumb) && File::file?(photo)
        thumb_width = MiniMagick::Image.open(thumb).width
        thumb_height = MiniMagick::Image.open(thumb).height
        width = MiniMagick::Image.open(photo).width
        height = MiniMagick::Image.open(photo).height

        ratio = width/thumb_width
        x = yk_user(:cropx) * ratio
        y = yk_user(:cropy) * ratio
        w = yk_user(:cropw) * ratio
        h = yk_user(:croph) * ratio

        temp_img = MiniMagick::Image.open(photo)
        temp_img.crop "#{w}x#{h}+#{x}+#{y}"
        temp_img.resize "512x512"
        temp_img.write thumb

      end
    end


    #user: username,pre,attache,phone,photo,year,age

    $post['year'] = $this->year;
    $swn_user = $this->swn->company->findOne(['id'=>$swn_id]);
    $post['age'] = Arr::get($swn_user, 'age', 0);
    $res = $this->swn->user->insertOne($post);
    $_id = (string) $res->getInsertedId();
    $this->redirect('/?_id='.$_id);


	end

	#上传维保相关的一些图片
  def upload_img
    filename = save_img(params[:photo])
    if filename
      thumb = "#{File::dirname(filename)}/#{File::basename(filename)}-thumb#{File::extname(filename)}"
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

  private

    def yk_user(key)
      params[:post][key]
    end

    def check_id(id)

    end

    def check_phone(phone)

    end


  #   private function check_id($id)
  # {
  #   if ($id == 'XXX-20170020') {
  #     return true;
  #   }
  #   $res = $this->swn->company->findOne(['id'=>$id]);
  #   if(empty($res)) {
  #     throw new HTTP_Exception_403(sprintf('该工牌号码 %s 不存在！', $id));
  #   }
  #   $user = $this->swn->user->findOne(['id'=>$id]+$this->filters);
  #   if($user) {
  #     throw new HTTP_Exception_403(sprintf('该工牌号码 %s 已被 %s 注册！', $id, $user->username));
  #   }
  #   return true;
  # }
  #
  # private function check_phone($phone)
  # {
  #   $count = $this->swn->user->count(['phone'=>$phone]+$this->filters);
  #   if($count) {
  #     throw new HTTP_Exception_403(sprintf('该电话号码 %s 已注册！', $phone));
  #   }
  #   return true;
  # }

end
