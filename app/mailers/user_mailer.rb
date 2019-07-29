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
      confirmation_link: event_application_confirm_url(event_id: application.event.id, application_id: application.random_id, host: "rgbworkshopapplication.herokuapp.com")
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
      event_place: application.event.place
    }

    mail(to: application.email, subject: Mustache.render(application.event.reminder_mail_subject, data )) do |format|
      format.html { render plain: Mustache.render(application.event.reminder_mail, data) }
    end
  end

  def reminder_attendance_mail(application)
    data = {
      applicant_name: application.name,
      event_date: I18n.l(application.event.scheduled_at),
      confirmation_link: event_application_confirm_url(event_id: application.event.id, application_id: application.random_id, host: "rgbworkshopapplication.herokuapp.com"),
      event_place: application.event.place
    }

    mail(to: application.email, subject: Mustache.render(application.event.reminder_attendance_mail_subject, data )) do |format|
      format.html { render plain: Mustache.render(application.event.reminder_attendance_mail, data) }
    end
  end

end
