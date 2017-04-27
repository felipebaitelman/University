class AddAttachmentSoundFileToSounds < ActiveRecord::Migration
  def self.up
    change_table :sounds do |t|
      t.attachment :sound_file
    end
  end

  def self.down
    remove_attachment :sounds, :sound_file
  end
end
