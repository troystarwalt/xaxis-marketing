# frozen_string_literal: true
class LandingPagesController < ApplicationController
  http_basic_authenticate_with name: "AllHands", password: "OneXaxis", only: [:all_hands, :all_hands_north_america]
  require 'will_paginate/array'

  def value_calculator
    @javascript_file_overwrite_name = 'landing_pages/value_calculator.js'
    @css_files_overwrite = 'landing_pages/value_calculator'
  end

  def expert_interview_hub
    @javascript_file_overwrite_name = 'landing_pages/expert_interview_hub.js'
    @css_files_overwrite = 'landing_pages/expert_interview_hub'
    if ExpertInterview.any?
      @main_video = ExpertInterview.last
      @rest_of_videos = ExpertInterview.where.not(id: @main_video.id).reverse.paginate(page: params[:page])
    end
  end

  def one_oh_one_series
    redirect_to "http://xaxis.hs-sites.com/101-series"
    # if OneOhOne.any?
    #   @one_oh_ones = OneOhOne.page(params[:page]).order('created_at ASC')
    # end
  end

  def group_m_signature
    @javascript_file_overwrite_name = 'landing_pages/signature.js'
    # @css_files_overwrite = 'landing_pages/signature'
  end

  def xaxis_signature
    @javascript_file_overwrite_name = 'landing_pages/signature.js'
  end

  def smart_kapp
  end

  # Landing Pages
  def all_hands_north_america
   # start here
   if authorized?
     @eventPhotos = Photo.all.tagged_with("all-hands")
     gon.photos = @eventPhotos
   else
     redirect_to root_path
   end
  end

  def all_hands_new_york
   # start here
   @eventPhotos = Photo.all.tagged_with("all-hands")
   gon.photos = @eventPhotos
  end

  def all_hands
    if authorized?
      @eventPhotos = Photo.all.tagged_with("all-hands")
      gon.photos = @eventPhotos
    else
      redirect_to root_path
    end
  end

  # This is a simple way to create a basic static page.
  # Simply create the page under lading-pages just like
  # you would access it in the url.
  # IE marekting.xaxis.com/pages/dinosaur
  # You would create a page under landing_pages/dinosaur.haml
  def show
    if valid_page?
      render "#{params[:page]}"
    else
      render 'errors/four_oh_four', status: 404  # If it isn't there, then poof, 404
    end
  end

  private
  def valid_page?
    File.exists?(Pathname.new(Rails.root + "app/views/landing_pages/#{params[:page]}.haml"))
  end
end
