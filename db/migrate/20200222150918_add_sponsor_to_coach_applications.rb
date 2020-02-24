class AddSponsorToCoachApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :coach_applications, :sponsor, :string
  end
end
