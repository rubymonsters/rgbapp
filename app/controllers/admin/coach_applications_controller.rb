class Admin::CoachApplicationsController < ApplicationsController
  layout "admin"

  before_action :require_admin
  before_action :find_event

  def index
    @coach_applications = @event.coach_applications.includes(coach: :user).
      order(params[:order] || "created_at desc")
  end

  def update_statuses
    approved_ids = params[:approved_ids] || [-1]
    # This code might cause performance problems. If application too slow, it needs refactoring.
    params[:state].each do |application_id, state|
      application = CoachApplication.find(application_id)
      application.state = state
      application.save!
    end

    @event.coach_applications.update_all(["lightningtalk_approved = (id IN (?))", approved_ids])

    redirect_to admin_event_coach_applications_path(@event), notice: "Cool! Changes saved."
  end

  def send_approval_emails
    @event.coach_applications.includes(coach: :user).to_contact.each do |coach_application|
      coach_application.update_attribute(:contacted_at, Time.now)
      UserMailer.coach_approval_mail(coach_application).deliver_later
    end

    redirect_to admin_event_coach_applications_path(@event), notice: "E-mails sent"
  end

  private

  def find_event
    @event = Event.find(params[:event_id])
  end
end
