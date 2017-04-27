class AddAttachmentAudioFileToVideos < ActiveRecord::Migration
  def self.up
    change_table :videos do |t|
      t.attachment :audio_file
    end
  end

  def self.down
    remove_attachment :videos, :audio_file
  end
end
