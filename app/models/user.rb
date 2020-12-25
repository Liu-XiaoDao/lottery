class User < ApplicationRecord
	validates :name, presence: true  #这几个不能为空
  validates :name, length: { in: 2..8 } #设备名长度6-25
	#validates :attendance,  uniqueness: { case_sensitive: false }#工号必须唯一
  belongs_to :user_list, optional: true
  has_many :families, dependent: :destroy
  after_create :sent_msg #发送报名通知

  def self.signin_count
    where(is_active: true).count
  end

  def sent_msg
    NotificationMailer.register_msg(self).deliver
    MessageService.send_msg_usms(phone, id)
  end
end
