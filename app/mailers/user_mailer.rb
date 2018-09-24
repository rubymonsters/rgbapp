class UserMailer < ApplicationMailer
  default from: "contact@railsgirlsberlin.de"

  def application_mail(application)
    @application = application
    mail(to: application.email, subject: "We have received your application for the Rails Girls Workshop")
  end

  def selection_mail(application)
    @application = application
    mail(to: application.email, subject: "Welcome to the Rails Girls Berlin (code curious) workshop on #{@application.event.scheduled_at.strftime("%d.%m.%Y")}. Please confirm!")
  end

  def reminder_mail(application)
    @application = application
    mail(to: application.email, subject: "Reminder: The Rails Girls Berlin (code curious) workshop will take place on #{@application.event.scheduled_at.strftime("%d.%m.%Y")}")
  end

  def rejection_mail(application)
    @application = application
    mail(to: application.email, subject: "Sorry! You have not been selected for the Rails Girls Berlin (code curious) workshop")
  end

  def waiting_list_mail(application)
    @application = application
    mail(to: application.email, subject: "You are on the waiting list")
  end

end
