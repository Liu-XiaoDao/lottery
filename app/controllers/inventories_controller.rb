class InventoriesController < ApplicationController
  layout 'template'
  http_basic_authenticate_with name: "abid_admin", password: "Abcam123", only: [:index, :upload]

  def index
    @inventories = Inventory.all.paginate page: params[:page], per_page: 50
  end

  def research_index

  end

  def research
    @inventories = ActiveRecord::Base.connection.execute("SELECT `inventories`.abid, `inventories`.size, `inventories`.unit, `inventories`.fridge, count(*) FROM `inventories` WHERE abid = '#{params[:post][:abid]}' GROUP BY size, fridge, unit")
  end

  def upload
    if !params[:files][0]
      redirect_to :inventories, alert: "You need select a file"
    else

      file = params[:files][0]
      # 保存的文件名
      save_file_name = "#{Time.now.strftime("%Y_%m_%d_%H_%M_%S")}.xlsx"
      File.open("#{Rails.root}/public/uploads/#{save_file_name}", "wb") do |f|
          f.write(file.read)
      end

      system("/usr/bin/python3 /var/www/inventory_xl.py #{Rails.root}/public/uploads/#{save_file_name} > #{Rails.root}/log/#{Time.now.strftime("%Y_%m_%d_%H_%M_%S")}.txt 2>&1")

      redirect_to inventories_url
    end

  end
end
