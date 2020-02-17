class CoachApplicationsController < ApplicationController
  layout "coach"
  before_action :find_event
  before_action :find_coach_application, only: :destroy
  before_action :require_coach
  before_action :check_application_status, only: [:new, :create]

  def new
    if @event.application_start > current_time
      flash[:error] = "Too early to apply"
      redirect_to events_coaches_path
    elsif @event.application_end < current_time
      render :too_late
    elsif !@event.coach_registration_enabled
      flash[:error] = "Registration not available"
      redirect_to events_coaches_path
    else
      @coach_application = CoachApplication.new
      @coach_application.coach = current_user.coach
      @coach_application.event = @event
    end
  end

  def create
    @coach_application = CoachApplication.new(create_coach_application_params)
    #make coach and event available for new view
    @coach_application.coach = current_user.coach
    @coach_application.event = @event

    if @coach_application.save
      render :successful_registration
    else
      render :new
    end
  end

  def destroy
    if @coach_application.destroy
      flash[:notice] = "Application cancelled"
    else
      flash[:error] = "Something went wrong"
    end

    redirect_to events_coaches_path
  end

  private

  def find_event
    @event = Event.find(params[:event_id])
  end

  def find_coach_application
    @coach_application = CoachApplication.find(params[:id])
  end

  def create_coach_application_params
    params.require(:coach_application).
      permit(:installationparty, :workshopday, :lightningtalk, :notes, :first_time_coaching)
  end

  def check_application_status
    if @event.coach_applications.find_by(coach_id: current_user.coach.id)
      flash[:error] = "You already applied"
      redirect_back(fallback_location: events_coaches_path)
    end
  end
end
