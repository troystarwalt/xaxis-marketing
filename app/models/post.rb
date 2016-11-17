# frozen_string_literal: true
class Post < ApplicationRecord
  validates :title, :text, presence: true
  validate :tag_must_be_approved
  mount_uploader :image, ImageUploader
  acts_as_taggable
  scope :tagged_by, -> (category){where(tags: {name: category})}
  self.per_page = 6
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders, :history]

  # best_result = ActiveRecord::Base.connection.execute("SELECT id, name, created_at, platform_id, file FROM logos
  #                                                     UNION SELECT id, name, created_at, platform_id, description FROM videos
  #                                                     UNION SELECT id, name, created_at, platform_id, description FROM infographics
  #                                                     UNION SELECT id, title, created_at, platform_id, author FROM case_studies
  #                                                     UNION SELECT id, name, created_at, brand_id, category  FROM brand_accessories
  #                                                     ORDER BY created_at DESC LIMIT 1")

  def slug_candidates
    [
      :title,
      [:title, :id],
    ]
  end

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

  def long_teaser
    text.truncate_words(120)
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
      img_url: self.image.url(:thumb),
      slug: self.slug
    }
  end

  private

  def tag_must_be_approved
    errors.add(:tag_list, 'Must select at least one tag from the list.') if (tag_list & Post.valid_tags) != tag_list
  end
end
