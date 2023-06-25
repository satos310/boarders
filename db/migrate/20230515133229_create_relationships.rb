class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :follower_id,   default: "", null: false
      t.integer :follow_id,     default: "", null: false
      t.timestamps
    end
  end
end
