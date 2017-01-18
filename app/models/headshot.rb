# frozen_string_literal: true
class Headshot < ApplicationRecord
  belongs_to :brand
  mount_uploader :grey_image, HeadshotsUploader
  mount_uploader :color_image, HeadshotsUploader
  validates_presence_of :first_name, :last_name, :title, :brand_id, :bio, presence: true
  scope :ordered_by_priority, -> {order(priority: :asc, last_name: :asc)}
  validates :grey_image, :color_image,
    :file_size => {
      :maximum => 15.megabytes.to_i
    }

  def full_name
    [first_name, last_name].join(' ')
  end

  def full_name=(name)
    elements = name.split(' ')
    self.last_name = elemetns.delete(elements.last)
    self.first_name = elements.join(" ")
  end
end
