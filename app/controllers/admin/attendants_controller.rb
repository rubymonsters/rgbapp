class Admin::AttendantsController < ApplicationController

  layout "admin"
  before_action :require_admin

  def index
    @event = Event.find(params[:event_id])
    @attendants = @event.applications.application_selected.confirmed
  end
end
