class Api::ContentController < Api::ApiController
  before_action :authenticate_user!

  def nature
    @videos = Video.joins(:themes).all
    res = @videos.as_json(:methods => [:audio_url, :video_url, :image_url])
    # Small hack to send the absolute url in the json.
    res.each do |v|
      v['video_url'] = (URI(request.url) + v['video_url']).to_s
      v['audio_url'] = (URI(request.url) + v['audio_url']).to_s
      v['image_url'] = (URI(request.url) + v['image_url']).to_s
    end
    render json: res
  end

  def infographics
    @info_pics=Hash.new
    @info_pics = Infographic.generate_display_mobil(@info_pics)
    res = @info_pics.as_json(:include =>
                                        {:image_sequences => {:include => {:image => {:methods => [:image_file],
                                                                                      :except => [:created_at, :updated_at, :name]}},
                                                              :except => [:created_at, :updated_at]},},
                                    :except => [:created_at, :updated_at, :added_by],
                                    :methods => [:image_url, :image_file_file_name])
    render json: res
  end

  def long_audio
    @audios = Sound.where(program: false)
    render json: @audios.to_json(:methods => [:sound_url, :video_url, :video_file_file_name, :image_url, :image_file_file_name])
  end

  def program
    programs = Program.generate_display_mobil()
    res = programs.as_json(:include =>
                               {:sound_sequences => {:include => {:sound => {:methods => [:sound_file],
                                                                             :except => [:created_at, :updated_at]}},
                                                     :except => [:created_at, :updated_at]},},
                           :except => [:created_at, :updated_at, :added_by],
    )
    render json: res
  end

end

