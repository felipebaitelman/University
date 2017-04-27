class PagesController < ApplicationController
  include Authorize

  before_action :logged, except: [:home, :login]

  def home
  end

  def login
  end

  def nature_display
    @videos = Video.all
    log = Log.new(media_id:1, media_type:'Video', user_id: current_user.id, date: DateTime.now)
    log.save
  end

  def long_audio_display
    @allLongAudio = Array.new
    Sound.where(program: false).each do |long_audio|
      @allLongAudio<<long_audio
    end
  end

  def infographics_display
    @info_pics = Infographic.generate_display_web()
  end

end
