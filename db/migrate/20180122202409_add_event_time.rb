class AddEventTime < ActiveRecord::Migration[5.1]
  def change
  	add_column :events, :start_time, :string, :null => false, :default => "10:00"
  	add_column :events, :end_time, :string, :null => false , :default => "18:00"
    change_column_default(:events, :start_time, from: "10:00", to: nil)
    change_column_default(:events, :end_time, from: "18:00", to: nil)
  end
end
