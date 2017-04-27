class CreateVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :videos do |t|
      t.string :name
      t.text :description
      t.integer :added_by
      t.integer :duration
      t.timestamps
    end
  end
end
