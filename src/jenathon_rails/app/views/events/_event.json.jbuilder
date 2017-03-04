json.extract! event, :id, :latitude, :longitude, :title, :description, :category, :targeted_at, :created_at, :updated_at
json.url event_url(event, format: :json)
