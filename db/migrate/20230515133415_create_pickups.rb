class CreatePickups < ActiveRecord::Migration[6.1]
  def change
    create_table :pickups do |t|
      t.integer :user,     null: false
      t.integer :review,   null: false
      t.timestamps
    end
  end
end
