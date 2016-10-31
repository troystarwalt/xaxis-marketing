class CaseStudiesController < ApplicationController
  def index
    if params[:platform_id]
      @case_studies = CaseStudy.joins(:platform).where(platforms: {slug: params[:platform_id]}).paginate(page: params[:page])
      @platform = Platform.friendly.find(params[:platform_id])
    else
      @case_studies = CaseStudy.paginate(page: params[:page])

    end
    @platforms = Platform.all
  end

  def show
    @case_study = CaseStudy.find(params[:id])
    @platforms = Platform.all
  end

  def search
    @case_studies = CaseStudy.includes(:platform, :taggings)

    if params[:case_studies_query][:product].present?
      @case_studies = @case_studies
                               .where(platforms: {slug: params[:case_studies_query][:product]})
    end

    if params[:case_studies_query][:industry].present?
      @case_studies = @case_studies.tagged_with(params[:case_studies_query][:industry])
    end
    
    @case_studies = @case_studies.paginate(page: params[:page])
    @platforms = Platform.all
    render 'index'
  end
end
