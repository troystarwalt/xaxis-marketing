class PresentationHubController < ApplicationController
  before_filter :get_our_brands

  def index
    @global_accessory = GlobalAccessory.last
  end

end
