class Coaches::EventsController < CoachesController

  def index
    @events = Event.all
  end

end
