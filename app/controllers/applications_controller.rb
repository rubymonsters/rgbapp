require 'securerandom'

class ApplicationsController < ApplicationController

  before_action :find_event

  def new
    if Time.now < @event.application_start
      render :too_early
    elsif Time.now > @event.application_end
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
