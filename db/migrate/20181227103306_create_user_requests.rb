class CreateUserRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :user_requests do |t|
      t.integer  :request_stat_id
      t.string   :url
      t.float    :time
      t.integer  :memory_usage
      t.string   :path
      t.text     :params
      t.string   :remote_ip
      t.timestamps
    end
  end
end
