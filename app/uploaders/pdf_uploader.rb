class PdfUploader < BaseUploader

  def extension_whitelist
    %w( pdf )
  end
end
