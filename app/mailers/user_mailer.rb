class UserMailer < ApplicationMailer
  default from: "contact@railsgirlsberlin.de"

  def application_mail(application)
    data = {
      applicant_name: application.name,
      event_date: application.event.scheduled_at.strftime("%d.%m.%Y"),
      confirmation_deadline: 5.days.from_now.strftime("%d.%m.%Y")
    }

    mail(to: application.email, subject: Mustache.render(application.event.application_mail_subject, data)) do |format|
      format.text { render plain: Mustache.render(application.event.application_mail, data) }
    end
  end

  def selection_mail(application)
    data = {
      applicant_name: application.name,
      event_date: application.event.scheduled_at.strftime("%d.%m.%Y"),
      confirmation_deadline: 5.days.from_now.strftime("%d.%m.%Y"),
      confirmation_link: event_application_confirm_url(event_id: application.event.id, application_id: application.random_id, host: "rgbworkshopapplication.herokuapp.com")
    }

    mail(to: application.email, subject: Mustache.render(application.event.selection_mail_subject, data)) do |format|
      format.text { render plain: Mustache.render(application.event.selection_mail, data) }
    end
  end

  def rejection_mail(application)
    data = {
      applicant_name: application.name
    }

    mail(to: application.email, subject: Mustache.render(application.event.rejection_mail_subject, data )) do |format|
      format.text { render plain: Mustache.render(application.event.rejection_mail, data ) }
    end
  end

  def waiting_list_mail(application)
    @application = application
    mail(to: application.email, subject: "You are on the waiting list")
  end

  def reminder_mail(application)
    data = {
      applicant_name: application.name,
      event_date: application.event.scheduled_at.strftime("%d.%m.%Y"),
      event_place: application.event.place
    }

    mail(to: application.email, subject: Mustache.render(application.event.reminder_mail_subject, data )) do |format|
      format.text { render plain: Mustache.render(application.event.reminder_mail, data) }
    end
  end

end
