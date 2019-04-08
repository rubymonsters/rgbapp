class CoachApplicationsController < ApplicationController
  layout "coach"
  before_action :find_event
  before_action :require_coach
  
  def new
    @coach_application = CoachApplication.new
    @coach_application.coach = current_user.coach
    @coach_application.event = @event
  end
  
  def create
    @coach_application = CoachApplication.new(params.require(:coach_application).permit(:installationparty, :workshopday, :lightningtalk, :notes))
    #update coach
    @coach = current_user.coach
    @coach.update(params.require(:coach_application).require(:coach_attributes).permit(:name, :female, :language_en, :language_de, :notifications))
    #make coach and event available for new view
    @coach_application.coach = @coach
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
end
