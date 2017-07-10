module ApplicationsHelper

def error_message(field)
  @application.errors[field].map do |error|
  "<p class=\"error_message\"> #{error} </p>"
end.join.html_safe
end

def order(field)
  if params[:order] == field
    "#{field} desc"
  else
    field
  end
end

end
