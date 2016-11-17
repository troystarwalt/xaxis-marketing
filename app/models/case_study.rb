# frozen_string_literal: true
class CaseStudy < ApplicationRecord
  include PgSearch
  belongs_to :platform
  mount_uploader :pdf_attachment, CaseStudyFileUploader
  self.per_page = 6
  before_save :capitalize_tags
  acts_as_taggable_on :industries, :regions
  pg_search_scope :search_for,
                    against: %w(title searchable_pdf_text),
                    using: {
                      tsearch: {
                        any_word: true}}

  REGION_LIST = [
    'APAC',
    'EMEA',
    'Latam',
    'North America'
  ].freeze

  def self.get_industry_tags_for_select
    all.map{|case_study| case_study.industries.map{|industry| industry.name }}.flatten.sort.uniq
  end

  def self.get_region_tags_for_select
    all.map{|case_study| case_study.regions.map{|region| region.name }}.flatten.sort.uniq
  end

  def get_pretty_release_date
    release_date.to_date.strftime("%m\/\%d\/\%Y")
  end

  def get_date_picker_release_date
    release_date.to_date.strftime("%Y-%m-%d")
  end

  def self.by_platforms(platforms)
    includes(:platform).where(platforms: {slug: platforms})
  end

  private
  def capitalize_tags
    self.industry_list = self.industry_list.map{|industry| industry.capitalize}.join(',')
  end

end
