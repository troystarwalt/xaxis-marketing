# frozen_string_literal: true
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_asset_path
  before_action :get_our_platforms
  before_action :get_our_brands
  rescue_from ActionController::RoutingError,
              ActionController::UnknownController,
              ::AbstractController::ActionNotFound,
              ActiveRecord::RecordNotFound,
              with: :catch_not_found

  def set_asset_path
    @bring_me_to_xaxis = Brand.find_by!(name: :Xaxis).slug
    @bring_me_to_turbine = Platform.find_by!(name: :Turbine).slug
  end

  def set_our_brands(slug)
    Brand.find_by!(slug: slug)
  end

  def get_our_brands
    @xaxis = set_our_brands('xaxis')
    @light_reaction = set_our_brands('light-reaction')
    @plista = set_our_brands('plista')
    @triad = set_our_brands('triad')
  end

  def catch_not_found
    render 'errors/four_oh_four', status: 404
  end

  def set_our_platforms(slug)
    Platform.find_by!(slug: slug)
  end

  def get_our_platforms
    @spotlight = set_our_platforms('spotlight')
    @turbine = set_our_platforms('turbine')
    @xanadu = set_our_platforms('xanadu')
  end

end
