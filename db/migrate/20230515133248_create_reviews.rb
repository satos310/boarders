class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :user,        null: false
      t.string :title,        null: false
      t.string :body,         null: false
      t.boolean :review_type, null: false, default: true
      t.timestamps
    end
  end
end
