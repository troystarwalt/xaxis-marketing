class OneOhOne < ApplicationRecord
  mount_uploader :ppt_file, PptUploader
  mount_uploader :pdf_file, PdfUploader
  mount_uploader :image_preview, ImageUploader
  scope :last_two, -> {order("created_at DESC").first(2)}

  self.per_page = 9
  validates_presence_of :name, :ppt_file, :pdf_file, :image_preview, presence: true
  validates :ppt_file,
  :file_size => {
    :maximum => 100.megabytes.to_i
  }
  validates :pdf_file,
  :file_size => {
    :maximum => 10.megabytes.to_i
  }

  validates :image_preview,
  :file_size => {
    :maximum => 5.megabytes.to_i
  }


end


#   scope :tagged_by, -> (category){where(tags: {name: category})}
