class AddReminderAttendanceMailToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :reminder_attendance_mail, :text
    add_column :events, :reminder_attendance_mail_subject, :text 
  end
end
