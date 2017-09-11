class AddApplicationsSelect < ActiveRecord::Migration[5.0]
  def change
    change_table :applications do |t|
      t.boolean :selected, :null => false, :default => false
    end
  end
end
