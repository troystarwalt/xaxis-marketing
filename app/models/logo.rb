# frozen_string_literal: true
class Logo < ApplicationRecord
  belongs_to :platform
  mount_uploader :file, LogoUploader
  validates_presence_of :platform, presence: true
  validates_presence_of :name, presence: true
  validates_presence_of :file, presence: true
  before_save :update_file_attributes

  def is_image?
    self.content_type.start_with? 'image'
  end

  private

  def update_file_attributes
    if file.present? && file_changed?
      self.content_type = file.file.content_type
      self.file_size = file.file.size
    end
  end

end
