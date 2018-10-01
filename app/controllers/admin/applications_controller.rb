class Admin::ApplicationsController < ApplicationController
  layout "admin"

  before_action :require_admin
  before_action :find_event

  def index
    @applications = @event.applications.order(params[:order] || "created_at desc")
    respond_to do |format|
      format.html
      format.csv { send_data @applications.to_csv }
    end
  end

  def checkboxes
    selected_ids = params[:selected_ids] || [-1]
    confirmed_ids = params[:confirmed_ids] || [-1]
    params[:state].each do |application_id, state|
      application = Application.find(application_id)
      application.state = state
      application.save!
    end  

    @event.applications.update_all(["attendance_confirmed = (id IN (?))", confirmed_ids])

    redirect_to admin_event_applications_path(@event), notice: "Cool! Changes saved."
  end

private

  def find_event
    @event = Event.find(params[:event_id])
  end

end
