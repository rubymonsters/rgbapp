class AddCoachRegistrationEnabledToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :coach_registration_enabled, :boolean, default: true
  end
end
