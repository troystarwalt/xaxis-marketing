# frozen_string_literal: true
class ImageUploader < BaseUploader


  version :thumb, :if => :image? do
    process resize_to_limit: [100, 100]
  end

  version :grid, :if => :image? do
    process resize_to_limit: [300, 400]
  end

  version :preview, :if => :image? do
    process resize_to_fit: [600, 600]
  end

  version :medium, :if => :image? do
    process resize_to_fit: [800, 800]
  end

  def extension_whitelist
    %w(png jpeg jpg)
  end

end
