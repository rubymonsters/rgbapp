class EventsController < ApplicationController
  def index
    @events = Event.all
  end
  def index_for_coaches
    @events = Event.all
  end
end
