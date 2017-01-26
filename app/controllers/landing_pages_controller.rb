# frozen_string_literal: true
class LandingPagesController < ApplicationController
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
    if OneOhOne.any?
      @one_oh_ones = OneOhOne.page(params[:page]).order('created_at ASC')
    end
  end

  def group_m_signature
    @javascript_file_overwrite_name = 'landing_pages/signature.js'
    # @css_files_overwrite = 'landing_pages/signature'
  end

  def xaxis_signature
    @javascript_file_overwrite_name = 'landing_pages/signature.js'
  end
end
