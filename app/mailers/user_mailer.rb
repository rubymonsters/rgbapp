class UserMailer < ApplicationMailer
  default from: "contact@railsgirlsberlin.de"

  def application_mail(application)
    mail(to: application.email, subject: "We have received your application for the Rails Girls Workshop") do |format|
      format.text { render plain: Mustache.render(application.event.application_mail,
        applicant_name: application.name,
        event_date: application.event.scheduled_at.strftime("%d.%m.%Y"),
        confirmation_deadline: 5.days.from_now.strftime("%d.%m.%Y")
        )
      }
    end
  end

  def selection_mail(application)
    mail(to: application.email, subject: "Welcome to the Rails Girls Berlin (code curious) workshop on #{application.event.scheduled_at.strftime("%d.%m.%Y")}. Please confirm!") do |format|
      format.text {
        render plain: Mustache.render(application.event.selection_mail,
          applicant_name: application.name,
          event_date: application.event.scheduled_at.strftime("%d.%m.%Y"),
          confirmation_deadline: 5.days.from_now.strftime("%d.%m.%Y"),
          confirmation_link: event_application_confirm_url(event_id: application.event.id, application_id: application.random_id, host: "rgbworkshopapplication.herokuapp.com")
        )
      }
    end
  end

  def rejection_mail(application)
    mail(to: application.email, subject: "Sorry! You have not been selected for the Rails Girls Berlin (code curious) workshop") do |format|
      format.text {
        render plain: Mustache.render(application.event.rejection_mail,
          applicant_name: application.name
        )
      }
    end
  end

  def reminder_mail(application)
    mail(to: application.email, subject: "Reminder: The Rails Girls Berlin (code curious) workshop will take place on #{application.event.scheduled_at.strftime("%d.%m.%Y")}") do |format|
      format.text {
        render plain: Mustache.render(application.event.reminder_mail,
          applicant_name: application.name,
          event_date: application.event.scheduled_at.strftime("%d.%m.%Y"),
          event_place: application.event.place
        )
      }
    end
  end
end
