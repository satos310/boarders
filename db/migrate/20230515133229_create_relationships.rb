# frozen_string_literal: true

class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :follower_id,   null: false
      t.integer :follow_id,     null: false
      t.timestamps
    end
  end
end
