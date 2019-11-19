class AddIdNumberIsAttendanceIsCarIsLunchToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :id_number, :string
    add_column :users, :is_attendance, :string
    add_column :users, :is_car, :string
    add_column :users, :is_lunch, :string
  end
end
