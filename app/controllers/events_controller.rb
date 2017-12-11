class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def update
    @event = Event.find(params[:id])
    @event.update_attributes(selection_complete: true)
    @event.applications.where(selected: true).each do |application|
      UserMailer.selection_mail(application).deliver_later
    end
    redirect_to event_applications_path(@event)
  end

end
