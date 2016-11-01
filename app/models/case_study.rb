class CaseStudy < ApplicationRecord
  include PgSearch
  belongs_to :platform
  mount_uploader :pdf_attachment, FileUploader
  self.per_page = 6
  acts_as_taggable_on :industries
  before_save :capitalize_tags
  pg_search_scope :search_for, against: %w(title searchable_pdf_text), using: { tsearch: { any_word: true } }
  def self.get_industry_tags_for_select
    ActsAsTaggableOn::Tag.joins(:taggings).where(taggings: {taggable_type: "CaseStudy"}).map{|tag| tag.name}
  end

  def get_pretty_release_date
    release_date.to_date.strftime("%m\/\%d\/\%Y")
  end

  def capitalize_tags
    self.industry_list = self.industry_list.map{|industry| industry.capitalize}.join(',')
  end



end
