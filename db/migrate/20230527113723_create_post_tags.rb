# frozen_string_literal: true

class CreatePostTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_tags do |t|
      t.integer :review_id,   null: false
      t.integer :hashtag_id,  null: false

      t.timestamps
    end
    # 同じタグを２回保存するのは出来ないようになる
    add_index :post_tags, [:review_id, :hashtag_id], unique: true
  end
end
