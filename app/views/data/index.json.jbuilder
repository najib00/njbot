json.array!(@data) do |datum|
  json.extract! datum, :id, :message
  json.url datum_url(datum, format: :json)
end
