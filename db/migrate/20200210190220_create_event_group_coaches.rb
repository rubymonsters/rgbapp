class CreateEventGroupCoaches < ActiveRecord::Migration[5.2]
  def change
    create_table :event_group_coaches do |t|
      t.references :coach_application, foreign_key: true
      t.references :event_group, foreign_key: true
      t.timestamps
    end
  end
end
