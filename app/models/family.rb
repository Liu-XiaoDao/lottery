class Family < ApplicationRecord
  belongs_to :user

  def is_attendance
    user.try(:is_attendance)
  end

  def is_car
    user.try(:is_car)
  end

  def phone
    user.try(:phone)
  end

  def notes
  end

  def leader_id
    user.try(:leader_id)
  end

  def gsyg
    user.try(:name)
  end
end
