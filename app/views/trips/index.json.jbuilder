json.array!(@trips) do |trip|
  json.extract! trip, :id, :location, :description
  json.url trip_url(trip, format: :json)
end
