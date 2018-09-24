class Admin::EventsController < ApplicationController
  layout "admin"

  before_action :require_admin
  before_action :find_event, only: [:edit, :update, :destroy, :complete, :send_emails]

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
    render :edit
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to admin_events_path
    else
      render :edit
    end
  end

  def edit
  end

  def update
    if @event.update_attributes(event_params)
      redirect_to admin_events_path
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to admin_events_path
  end

  def complete
    @event.update_attributes(selection_complete: true)
    send_selection_emails @event.applications.application_selected
    send_rejection_emails @event.applications.rejected
    send_waiting_list_emails @event.applications.waiting_list

    redirect_to admin_event_applications_path(@event)
  end

  def send_emails
    send_selection_emails @event.applications.application_selected.not_marked_as_selected
    redirect_to admin_event_applications_path(@event)
  end

private

    def find_event
      @event = Event.find(params[:id] || params[:event_id])
    end

    def event_params
      params.require(:event).permit(:name, :place, :scheduled_at, :application_start, :application_end, :confirmation_date, :start_time, :end_time)
    end

    def send_selection_emails(applications)
      applications.each do |application|
        UserMailer.selection_mail(application).deliver_later
        application.update_attributes(selected_on: Date.today)
      end
    end

    def send_rejection_emails(applications)
      applications.each do |application|
        UserMailer.rejection_mail(application).deliver_later
      end
    end
    
    def send_waiting_list_emails(applications)
      applications.each do |application|
        UserMailer.waiting_list_mail(application).deliver_later
      end
    end
end
