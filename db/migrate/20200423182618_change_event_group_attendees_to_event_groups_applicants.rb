class ChangeEventGroupAttendeesToEventGroupsApplicants < ActiveRecord::Migration[5.2]
  def change
    rename_table :event_group_attendees, :event_groups_applications
  end
end
