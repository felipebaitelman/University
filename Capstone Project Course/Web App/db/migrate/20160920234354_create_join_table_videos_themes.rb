class CreateJoinTableVideosThemes < ActiveRecord::Migration[5.0]
  def change
    create_join_table :videos, :themes do |t|
      t.index [:video_id, :theme_id]
      # t.index [:theme_id, :video_id]
    end
  end
end
