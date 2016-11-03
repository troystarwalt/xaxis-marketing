class LandingPagesController < ApplicationController

  def value_calculator
    @title = "Xaxis | Value Calculator"
    @javascript_file_overwrite_name = 'landing_pages/value_calculator.js'
    @css_files_overwrite = 'landing_pages/value_calculator'

  end

  def expert_interview_hub
    @title = "Xaxis | Expert Interview Hub"
    @javascript_file_overwrite_name = 'landing_pages/expert_interview_hub.js'
    @css_files_overwrite = 'landing_pages/expert_interview_hub'
  end

end
