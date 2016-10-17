class PlatformsController < ApplicationController

  around_filter :catch_not_found
  def index
    @platforms = Platform.all
  end

  def show
    @platform = Platform.friendly.find(params[:id])
    @spotlight_path = spotlight_path
    @turbine_path = turbine_path
    @xanadu_path = xanadu_path
  end

private
  def spotlight_path
  path = Platform.find_by(slug: :spotlight)
  end

  def turbine_path
  path = Platform.find_by(slug: :turbine)
  end

  def xanadu_path
    path = Platform.find_by(slug: :xanadu)
  end

end
