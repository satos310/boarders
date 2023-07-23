# frozen_string_literal: true

class CreateStars < ActiveRecord::Migration[6.1]
  def change
    create_table :stars do |t|
      t.integer :review_id, null: false
      t.string :name,       null: false
      t.float :score,       null: false, default: 0.0
      t.timestamps
    end
  end
end
