json.array!(@events) do |event|
  json.extract! event, :id, :title, :caption, :time_at, :event_img_url, :lng, :lat
  json.url event_url(event, format: :json)
end
