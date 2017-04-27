class CreateImageSequences < ActiveRecord::Migration[5.0]
  def change
    create_table :image_sequences do |t|
      t.belongs_to :infographic, index: true
      t.belongs_to :image, index: true
      t.integer :order
      t.timestamps
    end
  end
end
