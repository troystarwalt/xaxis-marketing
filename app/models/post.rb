class Post < ApplicationRecord
  validates :title, :text, presence: true
  validate :tag_must_be_approved
  acts_as_taggable

  def self.valid_tags
    ["Announcement", "News", "Event", "Talent and Culture"]
  end

  def pretty_date
    created_at.to_date.strftime("%m\/\%d\/\%Y")
  end

  private

  def tag_must_be_approved
    errors.add(:tag_list, 'Must select at least one tag from the list.') if (tag_list & Post.valid_tags) != tag_list
  end
end
