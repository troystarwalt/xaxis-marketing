# frozen_string_literal: true
class OneSheeter < ApplicationRecord
  belongs_to :platform
  mount_uploader :file, FileUploader
  validates_presence_of :platform, presence: true
  validates_presence_of :name, presence: true
  validates_presence_of :file, presence: true

end
