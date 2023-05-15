class CreateGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :genres do |t|
      t.references :review,     null: false, foreign_key: true
      t.string :name,           null: false, default: ""
      t.timestamps
    end
  end
end
