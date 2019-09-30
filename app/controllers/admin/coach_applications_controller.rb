class Admin::CoachApplicationsController < ApplicationsController
  layout "admin"

  before_action :require_admin
  before_action :find_event

  def index
    @coach_applications = @event.coach_applications.includes(coach: :user).
      order(params[:order] || "created_at desc")
  end

  private

  def find_event
    @event = Event.find(params[:event_id])
  end
end
