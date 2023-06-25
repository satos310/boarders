class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :user,           null: false
      t.integer :subject_type,   null: false
      t.integer :subject_id,     null: false
      t.integer :action_type,    null: false
      t.boolean :check_status,   null: false
      t.timestamps
    end
  end
end
