class PresentationHubController < ApplicationController
  before_filter :get_our_brands

  def index
    @brands = Brand.all
    @global_accessory = GlobalAccessory.last
  end

end
