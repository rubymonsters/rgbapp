class AddAttendedToApplications < ActiveRecord::Migration[5.1]
  def change
		add_column :applications, :attended, :boolean, default: false
  end
end
