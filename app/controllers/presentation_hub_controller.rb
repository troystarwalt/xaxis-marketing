# frozen_string_literal: true
class PresentationHubController < ApplicationController
  def index
    @brands_hub = Brand.includes(:brand_accessories).limit(4)
    @image_bank = GlobalAccessory.where(category: 'image_bank').last
  end
end
