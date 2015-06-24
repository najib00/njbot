json.array!(@updates) do |update|
  json.extract! update, :id, :update_id, :message
  json.url update_url(update, format: :json)
end
