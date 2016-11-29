module NavigationHelper
  def is_at_end_path(*url_parts)
    url_parts.each do |url_part|
      return 'active-sub-link' if request.path.match(/#{url_part}$/).present?
    end
    'non-active-sub-link'
  end
end
