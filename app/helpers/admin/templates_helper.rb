module Admin::TemplatesHelper

  def example_data
    {
      application_mail: {
        applicant_name: "Ruby",
        event_date: I18n.l(@event.scheduled_at),
        selection_email_deadline: I18n.l(@event.confirmation_date)
      },
      selection_mail: {
        applicant_name: "Ruby",
        event_date: I18n.l(@event.scheduled_at),
        confirmation_deadline: I18n.l(@event.confirmation_date + @event.confirmation_deadline),
        confirmation_link: event_application_confirm_url(event_id: @event.id, application_id: SecureRandom.hex(12)),
        cancel_link: event_application_cancel_url(event_id: @event.id, application_id: SecureRandom.hex(12))
      },
      rejection_mail: {
        applicant_name: "Ruby"
      },
      reminder_mail: {
        applicant_name: "Ruby",
        event_date: I18n.l(@event.scheduled_at),
        event_place: @event.place,
        cancel_link: event_application_cancel_url(event_id: @event.id, application_id: SecureRandom.hex(12)),
      },
      reminder_attendance_mail: {
        applicant_name: "Ruby",
        event_date: I18n.l(@event.scheduled_at),
        confirmation_link: event_application_confirm_url(event_id: @event.id, application_id: SecureRandom.hex(12))
      },
      waiting_list_mail: {
        applicant_name: "Ruby",
        event_date: I18n.l(@event.scheduled_at),
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
