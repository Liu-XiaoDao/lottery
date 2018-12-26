class User < ApplicationRecord
	validates :name,  :attendance, :avatar_url,  presence: true  #这几个不能为空
  validates :name,  :attendance,  length: { in: 2..25 } #设备名长度6-25
	#validates :attendance,  uniqueness: { case_sensitive: false }#工号必须唯一
  after_save :send_message

  def send_message
    ActionCable.server.broadcast 'signin', message: "render_message()"
  end
end
