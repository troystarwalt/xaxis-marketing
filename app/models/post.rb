class Post < ApplicationRecord
  validates :title, :text, presence: true
  validate :tag_must_be_approved
  mount_uploader :image, ImageUploader
  acts_as_taggable
  scope :tagged_by, -> (category){where(tags: {name: category})}
  self.per_page = 6

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

  def get_main_json
    {
      id: self.id,
      tag_list: self.get_tag_list.to_sentence,
      date: self.pretty_date,
      title: self.title,
      text: self.text,
      img_url: self.image.url(:thumb)
    }
  end

  private

  def tag_must_be_approved
    errors.add(:tag_list, 'Must select at least one tag from the list.') if (tag_list & Post.valid_tags) != tag_list
  end
end
