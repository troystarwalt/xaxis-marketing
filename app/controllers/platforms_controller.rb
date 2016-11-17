# frozen_string_literal: true
class PlatformsController < ApplicationController

  def show
    @platform = Platform.friendly.find(params[:id])
    @platform_videos = Video.where(platform_id: @platform.id)
    @platform_infos = Infographic.where(platform_id: @platform.id)
    @case_studies = CaseStudy.where(platform_id: @platform.id).includes(:platform).last(3)
    gon.videos = @platform.videos
    @platform_logo_png = Logo.where(platform_id: @platform.id, content_type: 'image/png').last
    @platform_logo_eps = Logo.where(platform_id: @platform.id, content_type: 'application/postscript').last
  end
end
