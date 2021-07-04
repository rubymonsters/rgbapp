class Admin::GroupsController < ApplicationController
  layout "admin"
  before_action :require_admin
  before_action :find_event

  GROUP_SIZE = 4

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

  def fetch_by_key(object, key)
    object[key] || []
  end

  def fill_groups
    # create a group for each pair of coaches
    @coaches = @event.coach_applications.approved.to_a
    @coaches.each_slice(1).with_index do |group, index|
      event_group = EventGroup.create(event: @event, name: "Group #{index + 1}")
      group.each do |coach_application|
        event_group.coach_applications << coach_application
      end
    end

    # get selected attendees from DB
    @attendees = @event.applications.application_selected.confirmed.to_a

    grouped_attendees_by_language = @attendees.group_by do |element|
      [element.language_de, element.language_en, element.os]
    end

    attendees_de_mac = fetch_by_key(grouped_attendees_by_language, [true, false, "mac"])
    attendees_de_windows = fetch_by_key(grouped_attendees_by_language, [true, false, "windows"])
    attendees_de_linux = fetch_by_key(grouped_attendees_by_language, [true, false, "linux"])

    attendees_en_mac = fetch_by_key(grouped_attendees_by_language, [false, true, "mac"])
    attendees_en_windows = fetch_by_key(grouped_attendees_by_language, [false, true, "windows"])
    attendees_en_linux = fetch_by_key(grouped_attendees_by_language, [false, true, "linux"])

    attendees_de_en_mac = fetch_by_key(grouped_attendees_by_language, [true, true, "mac"])
    attendees_de_en_windows = fetch_by_key(grouped_attendees_by_language, [true, true, "windows"])
    attendees_de_en_linux = fetch_by_key(grouped_attendees_by_language, [true, true, "linux"])

    attendees_de_mac_groups = attendees_de_mac.in_groups_of(GROUP_SIZE, false)
    attendees_de_windows_groups = attendees_de_windows.in_groups_of(GROUP_SIZE, false)
    attendees_de_linux_groups = attendees_de_linux.in_groups_of(GROUP_SIZE, false)
    attendees_en_mac_groups = attendees_en_mac.in_groups_of(GROUP_SIZE, false)
    attendees_en_windows_groups = attendees_en_windows.in_groups_of(GROUP_SIZE, false)
    attendees_en_linux_groups = attendees_en_linux.in_groups_of(GROUP_SIZE, false)

    [attendees_de_mac_groups, attendees_en_mac_groups].each do |groups|
      if groups.try :nonzero?
        if (groups.last.size < GROUP_SIZE)
          groups.last.concat(attendees_de_en_mac.pop(GROUP_SIZE - groups.last.size))
        end
      end
    end

    [attendees_de_linux_groups, attendees_en_linux_groups].each do |groups|
      if groups.try :nonzero?
        if(groups.last.size < GROUP_SIZE)
          groups.last.concat(attendees_de_en_linux.pop(GROUP_SIZE - groups.last.size))
        end
      end 
    end
    
    [attendees_de_windows_groups, attendees_en_windows_groups].each do |groups|
      if groups.try :nonzero?
        if(groups.last.size < GROUP_SIZE)
          groups.last.concat(attendees_de_en_windows.pop(GROUP_SIZE - groups.last.size))
        end
      end
    end

    de_en_groups_mac = attendees_de_en_mac.in_groups_of(GROUP_SIZE, false)
    de_en_groups_windows = attendees_de_en_windows.in_groups_of(GROUP_SIZE, false)
    de_en_groups_linux = attendees_de_en_windows.in_groups_of(GROUP_SIZE, false)

    all_groups = attendees_de_mac_groups + attendees_de_windows_groups + attendees_de_linux_groups + attendees_en_mac_groups + attendees_en_windows_groups + attendees_en_linux_groups + de_en_groups_mac + de_en_groups_windows + de_en_groups_linux


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
