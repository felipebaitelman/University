json.extract! video, :id, :name, :description, :date_added, :added_by, :label, :starting_content, :format, :duration, :resolution, :created_at, :updated_at
json.url video_url(video, format: :json)