class UserMailer < ApplicationMailer
  default from: "contact@railsgirlsberlin.de"

  def application_mail(application)
    data = {
      applicant_name: application.name,
      event_date: I18n.l(application.event.scheduled_at),
      selection_email_deadline: I18n.l(application.event.confirmation_date)
    }

    mail(to: application.email, subject: Mustache.render(application.event.application_mail_subject, data)) do |format|
      format.html { render plain: Mustache.render(application.event.application_mail, data) }
    end
  end

  def selection_mail(application)
    data = {
      applicant_name: application.name,
      event_date: I18n.l(application.event.scheduled_at),
      confirmation_deadline: I18n.l(application.event.confirmation_date + application.event.confirmation_deadline),
      confirmation_link: link_to("Confirm", confirmation_link(application)),
      cancel_link: link_to("Cancel", cancel_link(application))
    }

    mail(to: application.email, subject: Mustache.render(application.event.selection_mail_subject, data)) do |format|
      format.html { render plain: Mustache.render(application.event.selection_mail, data) }
    end
  end

  def rejection_mail(application)
    data = {
      applicant_name: application.name
    }

    mail(to: application.email, subject: Mustache.render(application.event.rejection_mail_subject, data )) do |format|
      format.html { render plain: Mustache.render(application.event.rejection_mail, data ) }
    end
  end

  def waiting_list_mail(application)
    data = {
      applicant_name: application.name,
      event_date: I18n.l(application.event.scheduled_at)
    }

    mail(to: application.email, subject: Mustache.render(application.event.waiting_list_mail_subject, data )) do |format|
      format.html { render plain: Mustache.render(application.event.waiting_list_mail, data) }
    end
  end

  def reminder_mail(application)
    data = {
      applicant_name: application.name,
      event_date: I18n.l(application.event.scheduled_at),
      event_place: application.event.place,
      cancel_link: link_to("Cancel", cancel_link(application))
    }

    mail(to: application.email, subject: Mustache.render(application.event.reminder_mail_subject, data )) do |format|
      format.html { render plain: Mustache.render(application.event.reminder_mail, data) }
    end
  end

  def reminder_attendance_mail(application)
    data = {
      applicant_name: application.name,
      event_date: I18n.l(application.event.scheduled_at),
      confirmation_link: link_to("Confirm", confirmation_link(application)),
      cancel_link: link_to("Cancel", cancel_link(application)),
      event_place: application.event.place
    }

    mail(to: application.email, subject: Mustache.render(application.event.reminder_attendance_mail_subject, data )) do |format|
      format.html { render plain: Mustache.render(application.event.reminder_attendance_mail, data) }
    end
  end

  private

  def confirmation_link(application)
    event_application_confirm_url(event_id: application.event.id, application_id: application.random_id)
  end

  def cancel_link(application)
    event_application_cancel_url(event_id: application.event.id, application_id: application.random_id)
  end

  def link_to(text, link)
    view_context.link_to text, link
  end
end
