class Episode < ApplicationRecord
  has_one_attached :audio
  has_rich_text :show_notes
end
