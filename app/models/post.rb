# frozen_string_literal: true
# require 'file_size_validator'
class Post < ApplicationRecord
  validates :title, :text, presence: true
  validate :tag_must_be_approved
  validates :image, :preview_image,
    :file_size => {
      :maximum => 5.megabytes.to_i
    }
  mount_uploader :image, ImageUploader
  mount_uploader :preview_image, ImageUploader
  acts_as_taggable
  scope :tagged_by, -> (category){where(tags: {name: category})}
  scope :published, -> {where.not(published_at: nil)}
  # scope :add_anchors_if_any_urls, -> test_for_url
  self.per_page = 6
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders, :history]

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
    published_at.to_date.strftime("%d")
  end

  def month_year_only
    published_at.to_date.strftime("%b, %Y")
  end

  def short_teaser
    text.truncate_words(20)
  end

  def medium_teaser
    text.truncate_words(40)
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
      img_url: self.image.url(:preview),
      slug: self.slug
    }
  end

  def next
    self.class.where("id > ? ", id).first(2)
  end

  def previous
    self.class.where("id < ? ", id).last(2)
  end



  private

  def tag_must_be_approved
    errors.add(:tag_list, 'Must select at least one tag from the list.') if (tag_list & Post.valid_tags) != tag_list
  end

end
