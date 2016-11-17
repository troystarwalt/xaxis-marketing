# frozen_string_literal: true
module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  # This allows us to highlight active links.
  def cp(path)
    "active-sub-link" if request.url.include?(path)
  end

  def render_developer_note
    return '' unless !Rails.env.production?
    return "We'll need to create a partial for this brand. Easy to copy and paste the xaxis version."
  end

  def file_is_image?(file_extension)
    %w(.jpeg .jpg .png .gif).include? File.extname(file_extension)
  end
end
