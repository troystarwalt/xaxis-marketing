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
    #formats search parameters to eliminate empty strings
    regions = params[:case_studies_query][:region].reject{|x| x.empty?}
    platforms = params[:case_studies_query][:product].reject{|x| x.empty?}
    industries = params[:case_studies_query][:industry].reject{|x| x.empty?}
    keywords = params[:case_studies_query][:keywords]

    #begins at all results
    case_studies = CaseStudy.all

    #narrows by keyword
    if keywords.present?
      #
      # pg_search returns odd results on associated tables,
      # so we get it before making associations to anything,
      # and limit the search by the ones with the ids in this
      # initial retun
      #
      case_study_search_results = CaseStudy.search_for(keywords)
      case_study_ids = case_study_search_results.map{|cs| cs.id}.uniq
      case_studies = case_studies.where(id: case_study_ids)
    end
    if regions.present?
      # to match either search term of a region
      case_studies = case_studies.tagged_with(regions, any: true)
    end
    if industries.present?
      # to match either search term of an industry
      case_studies = case_studies.tagged_with(industries, any: true)
    end
    if platforms.present?
      # to match platforms
      case_studies = case_studies.includes(:platform)
                               .where(platforms: {slug: platforms})
    end

    #paginate results at the end
    @case_studies = case_studies.paginate(page: params[:page])
    @platforms = Platform.all
    render 'index'
  end
end
