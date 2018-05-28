class Admin::EventsController < ApplicationController
  layout "admin"

  before_action :require_admin

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params.require(:event).permit(:name, :place, :scheduled_at, :start_time, :end_time, :application_start, :application_end, :confirmation_date))
    if @event.save
      redirect_to admin_events_path
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params.require(:event).permit(:name, :place, :scheduled_at, :application_start, :application_end, :confirmation_date, :start_time, :end_time))
      redirect_to admin_events_path
    else
      render :edit
    end
  end

  def destroy
    Event.find(params[:id]).destroy
    redirect_to admin_events_path
  end

  def complete
    @event = Event.find(params[:event_id])
    @event.update_attributes(selection_complete: true)
    @event.applications.where(selected: true).each do |application|
      UserMailer.selection_mail(application).deliver_later
      application.update_attributes(selected_on: Date.today)
    end
    @event.applications.where(selected: false).each do |application|
      UserMailer.rejection_mail(application).deliver_later
    end
    redirect_to admin_event_applications_path(@event)
  end
end
