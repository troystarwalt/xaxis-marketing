# frozen_string_literal: true
class CaseStudyFileUploader < BaseUploader
  after :store, :get_text_from_file

  def default_url(*args)
    random = ["xaxis", "lr", "turbine", "plista", "triad"]
    "https://robohash.org/#{random.sample}.png?size=200x200"
  end

  def extension_whitelist
    %w(pdf)
  end

  def get_text_from_file(file)
    reader = PDF::Reader.new(self.file.file)
    text = ""
    for page in reader.pages do
      text << page.text
    end
    self.model.update(searchable_pdf_text: text)
  end


end
