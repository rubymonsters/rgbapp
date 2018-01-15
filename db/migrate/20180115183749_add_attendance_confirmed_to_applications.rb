class AddAttendanceConfirmedToApplications < ActiveRecord::Migration[5.1]
  def change
    add_column :applications, :attendance_confirmed, :boolean, :null => false, :default => false
  end
end
