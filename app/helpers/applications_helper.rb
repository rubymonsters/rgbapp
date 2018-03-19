module ApplicationsHelper

def error_message(object, field)
  object.errors[field].map do |error|
  "<p class=\"error_message\"> #{error} </p>"
end.join.html_safe
end

end
