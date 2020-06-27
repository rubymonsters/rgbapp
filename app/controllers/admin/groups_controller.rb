class Admin::GroupsController < ApplicationController
  layout "admin"
  before_action :require_admin
  before_action :find_event

  def index
    @event_groups = @event.event_groups
    @coaches_count = @event.coach_applications.approved.size
    @attendees_count = @event.applications.application_selected.size
  end

  # An action to regenerate
  # -> a controller method
  # -> button (to call the action)
  # -> a route
  # -> isolate generate behaviour in its own method

  def generate
    fill_groups
    @event_groups = @event.event_groups
    redirect_to admin_event_groups_path(@event), notice: "Groups successfully generated"
  end

  def regenerate
    @event_groups = @event.event_groups
    @event_groups.destroy_all
    @event.reload

    fill_groups
    redirect_to admin_event_groups_path(@event), notice: "Groups successfully regenerated"
  end

  private

  def fill_groups
    # create a group for each pair of coaches
    @coaches = @event.coach_applications.approved.to_a
    @coaches.each_slice(2).with_index do |group, index|
      event_group = EventGroup.create(event: @event, name: "Group #{index + 1}")
      group.each do |coach_application|
        event_group.coach_applications << coach_application
      end
    end

    # get selected attendees from DB
    @attendees = @event.applications.application_selected.confirmed.to_a

    grouped_attendees_by_language = @attendees.group_by do |element|
      [element.language_de, element.language_en]
    end

    attendees_de = grouped_attendees_by_language[[true, false]]
    attendees_en = grouped_attendees_by_language[[false, true]]
    attendees_de_en = grouped_attendees_by_language[[true, true]]

    de_groups = attendees_de.in_groups_of(6, false)
    en_groups = attendees_en.in_groups_of(6, false)

    if (de_groups.last.size < 6)
      de_groups.last.concat(attendees_de_en.pop(6 - de_groups.last.size))
    end
    
    if (en_groups.last.size < 6)
      en_groups.last.concat(attendees_de_en.pop(6 - en_groups.last.size))
    end

    de_en_groups = attendees_de_en.in_groups_of(6, false)

    all_groups = de_groups + en_groups + de_en_groups

    # FIXME: This can cause attendees to not be assigned to event groups
    @event.event_groups.each do |event_group|
      group_to_add = all_groups.pop(1) 
      break if group_to_add.nil?
      event_group.applications << group_to_add
    end
  end

  def find_event
    @event = Event.find(params[:event_id])
  end
end
