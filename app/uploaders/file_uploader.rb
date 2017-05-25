# frozen_string_literal: true
class FileUploader < BaseUploader

  # version :thumb, :if => :image? do
  #   process resize_to_limit: [100, 100]
  # end
  #
  # version :preview, :if => :image? do
  #   process resize_to_fit: [400, 400]
  # end

  def extension_whitelist
      %w(zip pdf ppt pptx doc docx ase png eps jpeg jpg dotx)
  end

end
