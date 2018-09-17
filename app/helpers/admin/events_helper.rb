module Admin::EventsHelper

  def link_to_active(text, url)
    link_to(text, url, class: ("active" if current_page?(url)))
  end

end
