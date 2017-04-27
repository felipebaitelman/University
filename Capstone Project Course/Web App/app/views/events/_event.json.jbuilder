json.extract! event, :id, :event_type_id, :host_id, :faculty_id, :location, :capacity, :created_by, :start_hour, :end_hour, :day_id, :created_at, :updated_at
json.url event_url(event, format: :json)