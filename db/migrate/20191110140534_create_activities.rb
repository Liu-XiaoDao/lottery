class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.string 'name'  #活动名
      t.string 'date'  #活动日期
      t.string 'address' #活动地点
      t.string 'desc' #活动描述
      t.timestamps
    end
  end
end
