class AddEventDetails < ActiveRecord::Migration[5.0]
  def change
      change_table :events do |t|
        t.datetime :application_start
        t.datetime :application_end
        t.datetime :confirmation_date
      end
  end
end
