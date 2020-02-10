class CreateEventGroupAttendees < ActiveRecord::Migration[5.2]
  def change
    create_table :event_group_attendees do |t|
      t.references :application, foreign_key: true
      t.references :event_group, foreign_key: true
      t.timestamps
    end
  end
end
