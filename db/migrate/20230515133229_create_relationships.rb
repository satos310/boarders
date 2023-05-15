class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.references :follower,     null: false, foreign_key: true
      t.integer :following_id,    null: false, default: ""
      t.timestamps
    end
  end
end
