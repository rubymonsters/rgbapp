class CoachApplicationsController < ApplicationController
  layout "coach"
  before_action :find_event
  before_action :require_coach
  before_action :check_application_status

  def new
    @coach_application = CoachApplication.new
    @coach_application.coach = current_user.coach
    @coach_application.event = @event
  end

  def create
    @coach_application = CoachApplication.new(create_coach_application_params)
    #make coach and event available for new view
    @coach_application.coach = current_user.coach
    @coach_application.event = @event

    if @coach_application.save
      render html: 'Success'
    else
      render :new
    end
  end

  private

  def find_event
    @event = Event.find(params[:event_id])
  end

  def create_coach_application_params
    params.require(:coach_application).
      permit(:installationparty, :workshopday, :lightningtalk, :notes)
  end

  def check_application_status
    if @event.coach_applications.find_by(coach_id: current_user.coach.id)
      flash[:error] = "You already applied"
      redirect_back(fallback_location: events_coaches_path)
    end
  end
end
