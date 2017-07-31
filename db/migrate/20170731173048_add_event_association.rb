class AddEventAssociation < ActiveRecord::Migration[5.0]
  def change
    change_table :applications do |t|
      t.belongs_to :event, index: true
    end
  end
end
