class CreatePostTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_tags do |t|
      t.references :review,   null: false, foreign_key: true
      t.references :hashtag,  null: false, foreign_key: true

      t.timestamps
    end
    # 同じタグを２回保存するのは出来ないようになる
    add_index :post_tags, [:review_id, :hashtag_id], unique: true
  end
end
