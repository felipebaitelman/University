class CreateInfographics < ActiveRecord::Migration[5.0]
  def change
    create_table :infographics do |t|
      t.string :name
      t.text :description
      t.integer :added_by
      t.timestamps
    end
  end
end
