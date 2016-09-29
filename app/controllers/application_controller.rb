class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_asset_path, :set_our_brands

  def set_asset_path
    @bring_me_to_xaxis = Brand.where(name: :Xaxis).pluck(:slug)
  end

  def set_our_brands
    @our_brands = Brand.all
  end
end
