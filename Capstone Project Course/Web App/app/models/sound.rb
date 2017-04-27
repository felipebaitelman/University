class Sound < ApplicationRecord
  include Loggable

  has_attached_file :sound_file

  has_many :logs, as: :media
  has_and_belongs_to_many :themes

  has_many :sound_sequences
  has_many :programs, through: :sound_sequences

  validates_attachment_content_type :sound_file,
                                    :content_type => /^audio\/(mp3|mpeg|mpeg3|m4a|aac|mpg|x-mpg|x-mpg3|x-mp3|x-mpeg3)/,
                                    :message => 'only (mp3/mpeg/m4a/mpeg3/aac) audio'

  before_save :fetch_media_length

  def fetch_media_length
    duration_in_seconds = 1.0
    begin
      tempfile = sound_file.queued_for_write[:original]
      unless tempfile.nil?
        audio = FFMPEG::Movie.new(tempfile.path)
      	duration_in_seconds = audio.duration
      end
    end
    self.duration = duration_in_seconds
  end

  def sound_file_path
    self.sound_file.path
  end

  def sound_url
    self.sound_file.url
  end

  def video_url
    'http://especial2.ing.puc.cl/assets/lake2-53fb801a3600c8f4e1c1ff0965e320efde3f2b22222dc11857b989fdc5440a77.mp4'
  end

  def video_file_file_name
    'lake2.mp4'
  end

  def image_url
    'https://raw.githubusercontent.com/jachicao/Testing/master/lake2.png'
  end

  def image_file_file_name
    'lake2.png'
  end
end
