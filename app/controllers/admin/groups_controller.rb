class Admin::GroupsController < ApplicationController
  layout "admin"
  before_action :require_admin
  before_action :find_event

  def index
    @event_groups = @event.event_groups
  end

  def generate
    @attendees = @event.applications.application_selected.confirmed
    @attendees.each_slice(6).with_index do |group, index|
      event_group = EventGroup.create(event: @event, name: "Group #{index}")
      group.each do |application|
        event_group.applications << application
      end
    end

    @event_groups = @event.event_groups

    redirect_to admin_event_groups_path(@event), notice: "Groups successfully generated"
  end

  private

  def find_event
    @event = Event.find(params[:event_id])
  end
end
