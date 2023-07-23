# frozen_string_literal: true

class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :user_id,           null: false
      t.integer :subject_type,      null: false
      t.integer :subject_id,        null: false
      t.integer :action_type,       null: false
      t.boolean :check_status,      null: false, default: false
      t.timestamps
    end
  end
end
