class Admin::GroupsController < ApplicationController
  layout "admin"
  before_action :require_admin
  before_action :find_event

  def index
    @event_groups = @event.event_groups
  end

  def generate
    # This needs to be wrapped in a transaction
    @attendees = @event.applications.application_selected.confirmed
    @attendees.each_slice(6).with_index do |group, index|
      event_group = EventGroup.create(event: @event, name: "Group #{index + 1}")
      group.each do |application|
        event_group.applications << application
      end
    end

    @coaches = @event.coach_applications.approved.to_a
    @event.event_groups.each do |event_group|
      # Check if we are assinging the last 2 coaches
      coach_group = @coaches.pop(2)
      event_group.coach_applications << coach_group unless coach_group.empty?
    end

    @event_groups = @event.event_groups

    redirect_to admin_event_groups_path(@event), notice: "Groups successfully generated"
  end

  private

  def find_event
    @event = Event.find(params[:event_id])
  end
end
