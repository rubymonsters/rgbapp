class EventsController < ApplicationController
  before_action :check_if_coach, only: [:index]

  def index
    @events = Event.all
  end
end
