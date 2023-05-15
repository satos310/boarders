class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :user,           null: false, foreign_key: true
      t.references :subject_type,   null: false, foreign_key: true
      t.references :subject_id,     null: false, foreign_key: true
      t.references :action_type,    null: false, foreign_key: true
      t.boolean :check_status,      null: false, default: false
      t.timestamps
    end
  end
end
