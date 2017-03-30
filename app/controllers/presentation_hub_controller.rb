# frozen_string_literal: true
class PresentationHubController < ApplicationController
  def index
    @image_bank = GlobalAccessory.where(category: 'image_bank').last
  end
end
