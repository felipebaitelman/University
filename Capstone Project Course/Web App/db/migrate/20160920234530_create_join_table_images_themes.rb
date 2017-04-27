class CreateJoinTableImagesThemes < ActiveRecord::Migration[5.0]
  def change
    create_join_table :images, :themes do |t|
      t.index [:image_id, :theme_id]
      # t.index [:theme_id, :sound_id]
    end
  end
end
