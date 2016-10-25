class PlatformsController < ApplicationController
  before_filter :get_our_platforms
  around_filter :catch_not_found

  def index
    @platforms = Platform.all
  end

  def show
    @platform = Platform.friendly.find(params[:id])

    gon.videos = @platform.videos
  end
end
