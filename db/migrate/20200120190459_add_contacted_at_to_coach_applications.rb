class AddContactedAtToCoachApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :coach_applications, :contacted_at, :timestamp
  end
end
