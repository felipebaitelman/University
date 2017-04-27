json.extract! sound, :id, :name, :description, :date_added, :added_by, :label, :starting_content, :format, :duration, :bitrate, :created_at, :updated_at
json.url sound_url(sound, format: :json)