class Admin::GroupsController < ApplicationController
  layout "admin"
  before_action :require_admin
  before_action :find_event

  def index
  end

  def generate
    redirect_to admin_event_groups_path(@event), notice: "Groups successfully generated"
  end

  private

  def find_event
    @event = Event.find(params[:event_id])
  end
end
