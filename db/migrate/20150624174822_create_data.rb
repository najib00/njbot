class CreateData < ActiveRecord::Migration
  def change
    create_table :data do |t|
      t.text :message

      t.timestamps null: false
    end
  end
end
