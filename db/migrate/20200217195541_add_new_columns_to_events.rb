class AddNewColumnsToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :coach_the_coaches_date, :date
    add_column :events, :coach_the_coaches_start_time, :time
    add_column :events, :coach_the_coaches_end_time, :time
    add_column :events, :installation_get_together_date, :date
    add_column :events, :installation_get_together_start_time, :time
    add_column :events, :installation_get_together_end_time, :time
  end
end
