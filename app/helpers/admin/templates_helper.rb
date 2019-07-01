module Admin::TemplatesHelper

  def example_data
    {
      application_mail: {
        applicant_name: "Ruby",
        event_date: @event.scheduled_at.strftime("%d.%m.%Y"),
        selection_email_deadline: @event.confirmation_date.strftime("%d.%m.%Y")
      },
      selection_mail: {
        applicant_name: "Ruby",
        event_date: @event.scheduled_at.strftime("%d.%m.%Y"),
        confirmation_deadline: (@event.confirmation_date + @event.confirmation_deadline).strftime("%d.%m.%Y"),
        confirmation_link: event_application_confirm_url(event_id: @event.id, application_id: SecureRandom.hex(12))
      },
      rejection_mail: {
        applicant_name: "Ruby"
      },
      reminder_mail: {
        applicant_name: "Ruby",
        event_date: @event.scheduled_at.strftime("%d.%m.%Y"),
        event_place: @event.place
      },
      waiting_list_mail: {
        applicant_name: "Ruby",
        event_date: @event.scheduled_at.strftime("%d.%m.%Y"),
      }
    }
  end

  def preview_template(template_name)
    begin
      Mustache.render(@event[template_name], example_data[template_name.sub(/_subject$/,"").to_sym]).html_safe
			# TODO we have to check if it's really safe
  rescue => e
    "Error: #{e.message}"
  end
end
end
