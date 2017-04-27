class Video < ApplicationRecord
  include Loggable

  has_attached_file :video_file
  has_attached_file :audio_file
  has_attached_file :image_file

  has_many :logs, as: :media
  has_and_belongs_to_many :themes

  validates_attachment_content_type :video_file,
                                    :content_type => /^video\/(mpeg|mp4)/,
                                    :message => 'only (mpeg/mp4) videos'

  do_not_validate_attachment_file_type :audio_file


  before_save :fetch_media_length
  before_save :extract_audio
  before_save :take_snapshot

  def fetch_media_length
    duration_in_seconds = 1.0
    begin
      movie = FFMPEG::Movie.new(self.video_file.queued_for_write[:original].path)
      duration_in_seconds =movie.duration
    end
    self.duration=duration_in_seconds
  end

  def extract_audio
    begin
      movie = FFMPEG::Movie.new(self.video_file.queued_for_write[:original].path)
      movie.transcode("public/#{self.name}_audio_extract.mp3")
      file = File.open("public/#{self.name}_audio_extract.mp3")
      self.audio_file = file
      file.close
      File.delete("public/#{self.name}_audio_extract.mp3") if File.exist?("public/#{self.name}_audio_extract.mp3")
    end
  end

  def take_snapshot
    movie = FFMPEG::Movie.new(self.video_file.queued_for_write[:original].path)
    movie.screenshot("public/#{self.name}_screenshot.jpg")
    file = File.open("public/#{self.name}_screenshot.jpg")
    self.image_file = file
    file.close
    File.delete("public/#{self.name}_screenshot.jpg") if File.exist?("public/#{self.name}_screenshot.jpg")

  end

  def serve_random_videos

  end

  def video_url
    self.video_file.url
  end

  def audio_url
    self.audio_file.url
  end

  def image_url
    self.image_file.url
  end

end
