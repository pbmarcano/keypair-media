class Episode < ApplicationRecord
  has_one_attached :audio
  has_rich_text :show_notes

  scope :published, -> { where('published_at <= ?', Time.current) }
end
