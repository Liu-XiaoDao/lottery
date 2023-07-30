class User < ApplicationRecord
	validates :name, presence: true  #这几个不能为空
  validates :name, length: { in: 2..25 } #设备名长度6-25
	#validates :attendance,  uniqueness: { case_sensitive: false }#工号必须唯一
  belongs_to :user_list
  has_many :families, dependent: :destroy
  after_create :sent_msg #发送报名通知

  def self.signin_count
    where(is_active: true).count
  end

  def self.to_xlsx(records)
    # export_fields = ["name", "is_attendance", "is_lunch", "phone", "id_number", "is_car", "notes"]
    export_fields = ["name", "is_car"]
    SpreadsheetService.new.generate(export_fields, records)
  end

  def sent_msg
    # NotificationMailer.register_msg(self).deliver
    # system("/usr/bin/python3 /var/www/usms.py #{phone} #{id}")
  end

  def family_type
    "公司员工"
  end

  def height
  end

  def leader_id
    user_list.try(:leader_name)
  end

  def gsyg
  end
end
