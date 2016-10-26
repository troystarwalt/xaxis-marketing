class PlatformsController < ApplicationController
  before_filter :get_our_platforms
  around_filter :catch_not_found

  def index
    @platforms = Platform.all
  end

  def show
    @platform = Platform.friendly.find(params[:id])
    @case_studies = CaseStudy.where(platform_id: @platform.id)
    gon.videos = @platform.videos
    @platform_logo_png = Logo.where(platform_id: @platform.id, content_type: "image/png").last
    @platform_logo_eps = Logo.where(platform_id: @platform.id, content_type: "application/postscript").last
  end
end
