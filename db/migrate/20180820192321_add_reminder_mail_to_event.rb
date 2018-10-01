class AddReminderMailToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :reminder_mail, :text 
  end
end
