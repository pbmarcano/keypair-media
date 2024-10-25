json.extract! episode, :id, :title, :published_at, :description, :explicit, :duration, :created_at, :updated_at
json.url episode_url(episode, format: :json)
