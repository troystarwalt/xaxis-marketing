class Platform < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
end
