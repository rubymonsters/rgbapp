class AddReminderDateToEvents < ActiveRecord::Migration[5.1]
  def change
		  add_column :events, :reminder_date, :integer, null: false, default: 2
  end
end
