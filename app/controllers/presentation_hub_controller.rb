# frozen_string_literal: true
class PresentationHubController < ApplicationController

  def index
    @brands = Brand.all
    @global_accessory = GlobalAccessory.last
  end

end
