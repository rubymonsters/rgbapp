class EventsController < ApplicationController
  before_action :check_if_coach, only: [:index]

  def index
    @events = Event.all.sort_by &:scheduled_at
  end

  private

  def check_if_coach
    if current_user && current_user.coach
      redirect_to events_coaches_path
    end
  end
end
