class CreateJoinTableSoundsThemes < ActiveRecord::Migration[5.0]
  def change
    create_join_table :sounds, :themes do |t|
      t.index [:sound_id, :theme_id]
      # t.index [:theme_id, :sound_id]
    end
  end
end
