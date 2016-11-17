# frozen_string_literal: true
class ExpertInterviewImageUploader < BaseUploader

  def default_url(*args)
    random = ["xaxis", "lr", "turbine", "plista", "triad"]
    "https://robohash.org/#{random.sample}.png?size=200x200"
  end

  process resize_to_fit: [500, 900]

  def extension_whitelist
    %w(png jpeg jpg)
  end

end
