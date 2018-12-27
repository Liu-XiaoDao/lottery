class CreateRequestStats < ActiveRecord::Migration[5.1]
  def change
    create_table :request_stats do |t|
      t.string   :path
      t.integer  :count
      t.text     :params_stats
      t.float    :max_time
      t.float    :min_time
      t.float    :avg_time
      t.datetime :last_requested_at
      t.timestamps
    end
  end
end
