class AddAttachmentImageFileToVideos < ActiveRecord::Migration
  def self.up
    change_table :videos do |t|
      t.attachment :image_file
    end
  end

  def self.down
    remove_attachment :videos, :image_file
  end
end
