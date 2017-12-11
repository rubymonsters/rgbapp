class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def update
    @event = Event.find(params[:id])
    @event.update_attributes(selection_complete: true)
    redirect_to event_applications_path(@event)
  end

end
