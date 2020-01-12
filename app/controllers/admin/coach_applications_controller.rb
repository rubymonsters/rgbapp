class Admin::CoachApplicationsController < ApplicationsController
  layout "admin"

  before_action :require_admin
  before_action :find_event

  def index
    @coach_applications = @event.coach_applications.includes(coach: :user).
      order(params[:order] || "created_at desc")
  end

  def update_statuses
    confirmed_ids = params[:confirmed_ids] || [-1]
    approved_ids = params[:approved_ids] || [-1]
    # This code might cause performance problems. If application too slow, it needs refactoring.
    params[:state].each do |application_id, state|
      application = CoachApplication.find(application_id)
      application.state = state
      application.save!
    end

    @event.coach_applications.update_all(["coach_confirmed = (id IN (?))", confirmed_ids])
    @event.coach_applications.update_all(["lightningtalk_approved = (id IN (?))", approved_ids])

    redirect_to admin_event_coach_applications_path(@event), notice: "Cool! Changes saved."
  end

  private

  def find_event
    @event = Event.find(params[:event_id])
  end
end
