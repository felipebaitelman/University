json.extract! image, :id, :name, :description, :date_added, :added_by, :label, :starting_content, :format, :resolution, :created_at, :updated_at
json.url image_url(image, format: :json)