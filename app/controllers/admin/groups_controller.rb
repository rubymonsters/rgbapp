class Admin::GroupsController < ApplicationController
  layout "admin"
  before_action :require_admin
  before_action :find_event

  def index
    @event_groups = @event.event_groups
  end

  def generate

    # create a group for each pair of coaches
    @coaches = @event.coach_applications.approved.to_a
    @coaches.each_slice(2).with_index do |group, index|
      event_group = EventGroup.create(event: @event, name: "Group #{index + 1}")
      group.each do |coach_application|
        event_group.coach_applications << coach_application
      end
    end

    # add one attendee to each group as long as there are attendees in array
    @attendees = @event.applications.application_selected.confirmed.to_a
    @attendees.each do |attendee|
      @event.event_groups.each do |event_group|
        attendee_group = @attendees.pop(1)
        event_group.applications << attendee_group unless attendee_group.empty?
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
