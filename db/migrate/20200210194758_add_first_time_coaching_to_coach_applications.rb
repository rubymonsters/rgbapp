class AddFirstTimeCoachingToCoachApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :coach_applications, :first_time_coaching, :boolean, default: false
  end
end
