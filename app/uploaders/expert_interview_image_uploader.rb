# frozen_string_literal: true
class ExpertInterviewImageUploader < BaseUploader

  # def default_url(*args)
  #   random = ["xaxis", "lr", "turbine", "plista", "triad"]
  #   "https://robohash.org/#{random.sample}.png?size=200x200"
  # end

  version :fitting do
    process resize_to_fill: [900, 500]
  end

  def extension_whitelist
    %w(png jpeg jpg)
  end
end
