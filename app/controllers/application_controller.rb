# frozen_string_literal: true
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :get_our_brands
  rescue_from ActionController::RoutingError,
    ActionController::UnknownController,
    ::AbstractController::ActionNotFound,
    ActiveRecord::RecordNotFound,
    with: :catch_not_found

  def catch_not_found
    render 'errors/four_oh_four', status: 404
  end

  def get_our_brands
    @brands = Brand.all
  end

  protected # Only inherited controllers can call authorized?
  def authorized?
    request.authorization.present? && (request.authorization.split(' ', 2).first == 'Basic')
  end
end
