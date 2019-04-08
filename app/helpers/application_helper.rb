module ApplicationHelper
  def inside_layout(layout = "application", &block)
    render inline: capture(&block), layout: "layouts/#{layout}"
  end
  
  def logged_in_coach?
    @coach = current_user.coach if current_user      
  end
  
end
