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

  def select
    if params[:selected_ids]
      @event.applications.update_all(["selected = (id IN (?))", params[:selected_ids]])
    else
      @event.applications.update_all(selected: false)
    end
    redirect_to admin_event_applications_path(@event), notice: "Cool! Changes saved."
  end

private

  def find_event
    @event = Event.find(params[:event_id])
  end

end
