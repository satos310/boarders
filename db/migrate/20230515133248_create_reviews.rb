class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :user,     null: false, foreign_key: true
      t.string :title,        null: false, default: ""
      t.string :body,         null: false, default: ""
      t.boolean :review_type, null: false, default: true
      t.timestamps
    end
  end
end
