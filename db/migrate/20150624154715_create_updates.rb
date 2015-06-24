class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.integer :update_id
      t.text :message

      t.timestamps null: false
    end
    add_index :updates, :update_id
  end
end
