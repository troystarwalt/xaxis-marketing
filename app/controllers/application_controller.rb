class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_asset_path, :set_our_brands

  def set_asset_path
    @bring_me_to_xaxis = Brand.find_by(name: :Xaxis).slug
    @bring_me_to_turbine = Platform.find_by(name: :Turbine).slug
  end

  def set_our_brands
    @our_brands = Brand.all
  end

  def catch_not_found
    yield
  rescue ActiveRecord::RecordNotFound
    redirect_to root_url
    puts "oh not found"
  end

end
