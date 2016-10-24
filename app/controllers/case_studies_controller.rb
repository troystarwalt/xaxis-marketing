class CaseStudiesController < ApplicationController
  def index
    @case_studies = CaseStudy.all
  end

  def show
    @case_study = CaseStudy.find(params[:id])
  end
end
