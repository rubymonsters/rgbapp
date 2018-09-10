class ChangeTimestampsToDates < ActiveRecord::Migration[5.1]
  def change
    change_column :events, :scheduled_at, :date
    change_column :events, :application_start, :date
    change_column :events, :application_end, :date
    change_column :events, :confirmation_date, :date
  end
end
