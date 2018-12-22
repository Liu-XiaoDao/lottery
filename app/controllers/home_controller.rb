class HomeController < ApplicationController
  layout 'template'
  def qrcode
  end

  def upload_register
    if params[:files][0]
      save_file(params[:files][0],"register.png")
      return render json: {suc:1, msg:"上传成功"}
    else
      return render json: {suc:0, msg:"上传失败"}
    end
  end

  def upload_signin
    if params[:files][0]
      save_file(params[:files][0],"signin.png")
      return render json: {suc:1, msg:"上传成功"}
    else
      return render json: {suc:0, msg:"上传失败"}
    end
  end

  def save_file(file,file_name)
    file_path = "#{Rails.root}/public/#{file_name}"
    File.open(file_path,'wb+') do |item| #用二进制对文件进行写入
      item.write(file.read)
    end
  end
end
