class AddSelectedOnToApplications < ActiveRecord::Migration[5.1]
  def change
  	add_column :applications, :selected_on, :date
  end
end
