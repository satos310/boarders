class CreateStars < ActiveRecord::Migration[6.1]
  def change
    create_table :stars do |t|
      t.references :review, null: false, foreign_key: true
      t.string :name,      null: false, default: ""
      t.float :score,      null: false, default: 0.0
      t.float :all_score,  null: false, default: 0.0
      t.timestamps
    end
  end
end
