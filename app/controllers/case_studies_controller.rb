class CaseStudiesController < ApplicationController
  def index
    if params[:platform_id]
      @case_studies = CaseStudy.joins(:platform).where(platforms: {slug: params[:platform_id]})
      @platform = Platform.friendly.find(params[:platform_id])
    else
      @case_studies = CaseStudy.all
    end
    @platforms = Platform.all
  end

  def show
    @case_study = CaseStudy.find(params[:id])
    @platforms = Platform.all
  end

  def search
    if params[:case_studies_query][:product]
      @case_studies = CaseStudy.joins(:platform)
                               .where(platforms: {slug: params[:case_studies_query][:product]})
      #add region and industry later
    end
    @platforms = Platform.all
    render 'index'
  end
end
