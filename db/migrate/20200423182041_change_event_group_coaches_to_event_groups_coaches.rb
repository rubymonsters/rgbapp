class ChangeEventGroupCoachesToEventGroupsCoaches < ActiveRecord::Migration[5.2]
  def change
    rename_table :event_group_coaches, :event_groups_coaches
  end
end
