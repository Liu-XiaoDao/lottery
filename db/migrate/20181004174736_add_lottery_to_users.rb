class AddLotteryToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :lottery, :integer
  end
end
