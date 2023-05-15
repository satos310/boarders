class CreatePickups < ActiveRecord::Migration[6.1]
  def change
    create_table :pickups do |t|
      t.references :user,     null: false, foreign_key: true
      t.references :review,   null: false, foreign_key: true
      t.timestamps
    end
  end
end
