class CreateSoundSequences < ActiveRecord::Migration[5.0]
  def change
    create_table :sound_sequences do |t|
      t.belongs_to :program, index: true
      t.belongs_to :sound, index: true
      t.integer :order
      t.timestamps
    end
  end
end
