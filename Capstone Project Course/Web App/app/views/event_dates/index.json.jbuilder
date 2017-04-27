json.array!(@event_dates) do |e|
  json.extract! e, :id, :event_id, :host_id, :location, :capacity
  json.start e.start_date
  json.end e.end_date
  json.title e.event_id
  json.url event_date_url(e, format: :html)
end

