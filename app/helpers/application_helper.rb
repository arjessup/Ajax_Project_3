module ApplicationHelper
  
  def logo
      logo = image_tag("icon.png", :alt => "AJAX Project 3", :class => "round")
  end
  
  # Return on a per-page basis
  def title
    base_title = "AJAX Project 3"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
