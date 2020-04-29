class ChangeEventGroupsCoachesToEventGroupsCoachApplications < ActiveRecord::Migration[5.2]
  def change
    rename_table :event_groups_coaches, :event_groups_coach_applications
  end
end
