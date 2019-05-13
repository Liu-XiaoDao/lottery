class User < ApplicationRecord
	validates :name, :avatar_url,  presence: true  #这几个不能为空
  validates :name, length: { in: 2..25 } #设备名长度6-25
	#validates :attendance,  uniqueness: { case_sensitive: false }#工号必须唯一

  def self.signin_count
    where(is_active: true).count
  end
end
