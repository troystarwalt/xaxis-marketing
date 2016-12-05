class PptUploader < BaseUploader

  def extension_whitelist
    %w(ppt pptx)
  end

end
