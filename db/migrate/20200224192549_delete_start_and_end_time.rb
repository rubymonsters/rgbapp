class DeleteStartAndEndTime < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :start_time
    remove_column :events, :end_time
    add_column :events, :start_time, :time
    add_column :events, :end_time, :time

    Event.all.each do |event|
      event.update_columns(start_time: "09:00", end_time: "18:00")
    end

    change_column :events, :start_time, :time, null: false
    change_column :events, :end_time, :time, null: false
  end
end
