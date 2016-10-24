class CaseStudy < ApplicationRecord
  belongs_to :platform
  mount_uploader :pdf_attachment, FileUploader

  def get_pretty_release_date
    release_date.to_date.strftime("%m\/\%d\/\%Y")
  end
end
