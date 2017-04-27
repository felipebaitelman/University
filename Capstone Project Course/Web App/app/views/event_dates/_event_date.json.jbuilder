json.extract! event_date, :id, :event_id, :start_date, :end_date, :host_id, :location, :capacity, :created_at, :updated_at
json.url event_date_url(event_date, format: :json)