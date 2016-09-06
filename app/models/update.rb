class Update < ApplicationRecord
  validates :title, :text, presence: true
end
