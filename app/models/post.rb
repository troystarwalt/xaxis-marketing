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
    created_at.to_date.strftime("%d")
  end

  def month_year_only
    created_at.to_date.strftime("%b, %Y")
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

  # future
    # def make_pretty_links(arr)
    #   puts "making it pretty"
    #   # byebug
    #   arr.each do |q|
    #     byebug
    #     "<a href='#{q.to_s}'>'#{q.to_s}'</a>"
    #   end
    # end
    # def test_for_url(str)
    #   url_regex = %r{(?i)\b((?:https?:(?:/{1,3}|[a-z0-9%])|[a-z0-9.\-]+[.](?:com|net|org|edu|gov|mil|aero|asia|biz|cat|coop|info|int|jobs|mobi|museum|name|post|pro|tel|travel|xxx|ac|ad|ae|af|ag|ai|al|am|an|ao|aq|ar|as|at|au|aw|ax|az|ba|bb|bd|be|bf|bg|bh|bi|bj|bm|bn|bo|br|bs|bt|bv|bw|by|bz|ca|cc|cd|cf|cg|ch|ci|ck|cl|cm|cn|co|cr|cs|cu|cv|cx|cy|cz|dd|de|dj|dk|dm|do|dz|ec|ee|eg|eh|er|es|et|eu|fi|fj|fk|fm|fo|fr|ga|gb|gd|ge|gf|gg|gh|gi|gl|gm|gn|gp|gq|gr|gs|gt|gu|gw|gy|hk|hm|hn|hr|ht|hu|id|ie|il|im|in|io|iq|ir|is|it|je|jm|jo|jp|ke|kg|kh|ki|km|kn|kp|kr|kw|ky|kz|la|lb|lc|li|lk|lr|ls|lt|lu|lv|ly|ma|mc|md|me|mg|mh|mk|ml|mm|mn|mo|mp|mq|mr|ms|mt|mu|mv|mw|mx|my|mz|na|nc|ne|nf|ng|ni|nl|no|np|nr|nu|nz|om|pa|pe|pf|pg|ph|pk|pl|pm|pn|pr|ps|pt|pw|py|qa|re|ro|rs|ru|rw|sa|sb|sc|sd|se|sg|sh|si|sj|Ja|sk|sl|sm|sn|so|sr|ss|st|su|sv|sx|sy|sz|tc|td|tf|tg|th|tj|tk|tl|tm|tn|to|tp|tr|tt|tv|tw|tz|ua|ug|uk|us|uy|uz|va|vc|ve|vg|vi|vn|vu|wf|ws|ye|yt|yu|za|zm|zw)/)(?:[^\s()<>{}\[\]]+|\([^\s()]*?\([^\s()]+\)[^\s()]*?\)|\([^\s]+?\))+(?:\([^\s()]*?\([^\s()]+\)[^\s()]*?\)|\([^\s]+?\)|[^\s`!()\[\]{};:'".,<>?«»“”‘’])|(?:(?<!@)[a-z0-9]+(?:[.\-][a-z0-9]+)*[.](?:com|net|org|edu|gov|mil|aero|asia|biz|cat|coop|info|int|jobs|mobi|museum|name|post|pro|tel|travel|xxx|ac|ad|ae|af|ag|ai|al|am|an|ao|aq|ar|as|at|au|aw|ax|az|ba|bb|bd|be|bf|bg|bh|bi|bj|bm|bn|bo|br|bs|bt|bv|bw|by|bz|ca|cc|cd|cf|cg|ch|ci|ck|cl|cm|cn|co|cr|cs|cu|cv|cx|cy|cz|dd|de|dj|dk|dm|do|dz|ec|ee|eg|eh|er|es|et|eu|fi|fj|fk|fm|fo|fr|ga|gb|gd|ge|gf|gg|gh|gi|gl|gm|gn|gp|gq|gr|gs|gt|gu|gw|gy|hk|hm|hn|hr|ht|hu|id|ie|il|im|in|io|iq|ir|is|it|je|jm|jo|jp|ke|kg|kh|ki|km|kn|kp|kr|kw|ky|kz|la|lb|lc|li|lk|lr|ls|lt|lu|lv|ly|ma|mc|md|me|mg|mh|mk|ml|mm|mn|mo|mp|mq|mr|ms|mt|mu|mv|mw|mx|my|mz|na|nc|ne|nf|ng|ni|nl|no|np|nr|nu|nz|om|pa|pe|pf|pg|ph|pk|pl|pm|pn|pr|ps|pt|pw|py|qa|re|ro|rs|ru|rw|sa|sb|sc|sd|se|sg|sh|si|sj|Ja|sk|sl|sm|sn|so|sr|ss|st|su|sv|sx|sy|sz|tc|td|tf|tg|th|tj|tk|tl|tm|tn|to|tp|tr|tt|tv|tw|tz|ua|ug|uk|us|uy|uz|va|vc|ve|vg|vi|vn|vu|wf|ws|ye|yt|yu|za|zm|zw)\b/?(?!@)))}
    #
    #   if str.scan(url_regex)
    #     puts "fucking match"
    #     matched_links = str.scan(url_regex)
    #     make_pretty_links(matched_links)
    #   else
    #     puts "negative"
    #   end
    # end
end
