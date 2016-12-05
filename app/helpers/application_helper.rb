module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  # This allows us to highlight active links. IE cp = current path
  # def cp(path)
  #   'active-sub-link' if request.url.include?("/" + path)
  #   byebug
  # end

  def render_developer_note
    return '' unless !Rails.env.production?
    return "We'll need to create a partial for this brand. Easy to copy and paste the xaxis version."
  end

  def file_is_image?(file_extension)
    %w(.jpeg .jpg .png .gif).include? File.extname(file_extension)
  end

    # Custom helper methods to return flash types.
  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

  # We can call this below helper by putting =flash_messages on
  # application.html.haml. It checks the type of message returns that
  # bootstrap style, adds a close button and adds in the message.
  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in alert-dismissible", id: "flash_container") do
              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
              concat message
            end)
    end
    nil
  end

end
