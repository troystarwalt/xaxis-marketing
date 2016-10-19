class Post < ApplicationRecord
  validates :title, :text, presence: true
  validate :tag_must_be_approved
  acts_as_taggable

  scope :tagged_by, -> (category){where(tags: {name: category})}
  def self.valid_tags
    ["Announcement", "News", "Event", "Talent & Culture"]
  end

  def day_only
    created_at.to_date.strftime("%m")
  end

  def month_year_only
    created_at.to_date.strftime("%b, %Y")
  end

  def teaser
      text.truncate_words(15)
  end

  def get_tag_list
    tags.map{|tag| tag.name}
  end

  private

  def tag_must_be_approved
    errors.add(:tag_list, 'Must select at least one tag from the list.') if (tag_list & Post.valid_tags) != tag_list
  end
end
