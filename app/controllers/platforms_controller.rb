class PlatformsController < ApplicationController

  around_filter :catch_not_found
  def index
    @platforms = Platform.all
  end

  def show
    @platform = Platform.friendly.find(params[:id])
  end
  
end
