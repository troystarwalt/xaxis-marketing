# frozen_string_literal: true
class ExpertInterview < ApplicationRecord
  mount_uploader :image, ExpertInterviewImageUploader
  self.per_page = 8

  validates_presence_of :title, presence: true
  validates_presence_of :vimeo_url, presence: true
  validates_presence_of :contributor_name, presence: true
  validates_presence_of :contributor_title, presence: true
  validates_presence_of :image

end
