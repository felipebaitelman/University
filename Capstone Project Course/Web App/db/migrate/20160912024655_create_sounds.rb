class CreateSounds < ActiveRecord::Migration[5.0]
  def change
    create_table :sounds do |t|
      t.string :name
      t.text :description
      t.integer :added_by
      t.integer :duration
      t.boolean :program
      t.timestamps
    end
  end
end
