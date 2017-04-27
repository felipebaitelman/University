json.array!(@events) do |event|
  json.extract! event, :id, :event_type_id, :host_id
  json.start event.start_hour
  json.end event.end_hour
  json.url event_url(event, format: :html)
end