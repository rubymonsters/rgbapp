class Admin::EventsController < ApplicationController

  before_action :require_admin

  def complete
    @event = Event.find(params[:event_id])
    @event.update_attributes(selection_complete: true)
    @event.applications.where(selected: true).each do |application|
      UserMailer.selection_mail(application).deliver_later
      application.update_attributes(selected_on: Date.today)
    end
    redirect_to admin_event_applications_path(@event)
  end
end
