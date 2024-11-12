json.extract! episode, :id, :title, :published_at, :description, :explicit, :created_at, :updated_at
json.url episode_url(episode, format: :json)
