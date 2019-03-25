class CoachApplicationsController < ApplicationController
  before_action :find_event
  
  def new
    @coach_application = CoachApplication.new
    @coach_application.coach = Coach.find_by_id(1)
    @coach_application.event = @event
  end
  
  def create
    @coach_application = CoachApplication.new(params.require(:coach_application).permit(:installationparty, :workshopday, :lightningtalk, :notes))
    @coach_application.event = @event
    @coach_application.coach = Coach.find_by_id(1)
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
