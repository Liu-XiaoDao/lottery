class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string   'name'   #员工姓名
      t.string   'attendance'  #工号
      t.string   'avatar_url'    #头像
      t.boolean  'is_active',           default: false
      t.timestamps
    end
  end
end
