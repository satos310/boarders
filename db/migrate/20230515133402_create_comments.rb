class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :user,        null: false
      t.integer :review,      null: false
      t.string :comment,      null: false
      t.timestamps
    end
  end
end
