module ApplicationHelper

  def cp(path)
    "active-sub-link" if request.url.include?(path)
  end
end
