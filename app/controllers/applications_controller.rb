require 'securerandom'

class ApplicationsController < ApplicationController

  before_action :find_event

  def new
    # We want the periods to start and end at midnight in Berlin, not UTC.
    # A possible improvement could be to configure a time zone for each event, instead of hardcoding it to Berlin.
    date_in_berlin = Time.now.in_time_zone("Berlin").to_date

    if @event.application_start > date_in_berlin
      render :too_early
    elsif @event.application_end < date_in_berlin
      render :too_late
    else
      @application = Application.new
    end
  end

  def create
    @application = @event.applications.build(params.require(:application).permit(:name,
      :email, :language_de, :language_en, :attended_before, :rejected_before, :level,
      :comments, :os, :needs_computer, :read_coc, :female))

    @application.random_id = SecureRandom.hex(12)
    @application.sequence_number = @event.applications.count + 1

    if @application.save
      UserMailer.application_mail(@application).deliver_later
    else
      render :new
    end
  end

  def confirm
    @application = @event.applications.find_by!(random_id: params[:application_id], selected: true)
    if Date.today - @application.selected_on > 5
      render :confirmed_too_late
    else
      @application.update_attributes(attendance_confirmed: true)
    end
  end

private

  def find_event
    @event = Event.find(params[:event_id])
  end

end
