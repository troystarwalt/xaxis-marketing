class Post < ApplicationRecord
  validates :title, :text, presence: true
  acts_as_taggable
end
