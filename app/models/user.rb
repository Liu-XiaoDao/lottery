class User < ApplicationRecord
	validates :name, :avatar_url,  presence: true  #这几个不能为空
  validates :name, length: { in: 2..25 } #设备名长度6-25
	#validates :attendance,  uniqueness: { case_sensitive: false }#工号必须唯一
  after_save :send_message, if: :is_active_changed?

  def self.signin_count
    where(is_active: true).count
  end

  def send_message
    puts "--------------------------------"
    ActionCable.server.broadcast 'signin', message: {user_info: User.last, signin_count: User.signin_count}
  end
end
