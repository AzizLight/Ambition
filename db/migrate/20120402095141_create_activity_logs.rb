class CreateActivityLogs < ActiveRecord::Migration
  def change
    create_table :activity_logs do |t|
      t.string :name
      t.string :description
      t.string :entity
      t.integer :user_id
      t.string :ip_address

      t.timestamps
    end
  end
end
