class AddCoachTheCoachesToCoachApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :coach_applications, :coach_the_coaches, :boolean, default: false
  end
end
