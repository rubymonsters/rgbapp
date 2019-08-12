module ApplicationsHelper

  def error_message(object, field)
    object.errors[field].map do |error|
      "<p class=\"error_message\"> #{error} </p>"
    end.join.html_safe
  end

  def application_states_for_select
    Application.states.map do |key, _|
      [Application.human_attribute_name("state.#{key}"), key]
    end
  end
end
