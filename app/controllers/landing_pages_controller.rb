class LandingPagesController < ApplicationController
  require 'will_paginate/array'
  def value_calculator
    @title = "Xaxis | Value Calculator"
    @javascript_file_overwrite_name = 'landing_pages/value_calculator.js'
    @css_files_overwrite = 'landing_pages/value_calculator'

  end

  def expert_interview_hub
    @title = "Xaxis | Expert Interview Hub"
    @javascript_file_overwrite_name = 'landing_pages/expert_interview_hub.js'
    @css_files_overwrite = 'landing_pages/expert_interview_hub'
    @main_video = ExpertInterview.last
    @rest_of_videos = ExpertInterview.where.not(id: @main_video.id).reverse.paginate(page: params[:page])
  end

end
