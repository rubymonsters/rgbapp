require 'securerandom'

class ApplicationsController < ApplicationController
  before_action :find_event

  def new
    if @event.application_start > current_time
      render :too_early
    elsif @event.application_end < current_time
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
    @application = @event.applications.application_selected.find_by!(random_id: params[:application_id])
    if @application.too_late_to_confirm?(current_time)
      render :confirmed_too_late
    else
      if @application.update_attributes(attendance_confirmed: true)
        render :confirm
      else
        render :error
      end
    end
  end

  def cancel
    @application = @event.applications.application_selected.find_by!(random_id: params[:application_id])
    if @application.update_attributes(state: "cancelled", attendance_confirmed: false)
      render :cancel
    else
      render :error
    end
  end

private

  def find_event
    @event = Event.find(params[:event_id])
  end
end
