class Admin::AttendantsController < ApplicationController

  layout "admin"
  before_action :require_admin

  def index
    @event = Event.find(params[:event_id])
    @attendants = @event.applications.application_selected.confirmed
  end

  def update
    @event = Event.find(params[:event_id])
    @attendant = @event.applications.find(params[:id])
    @attendant.update_attributes!(params.require(:attendant).permit(:attended))
    ActionCable.server.broadcast 'attendants', @attendant
  end

end
