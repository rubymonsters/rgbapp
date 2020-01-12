class AddCoachConfirmedToCoachApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :coach_applications, :coach_confirmed, :boolean, :null => false, :default => false
  end
end
