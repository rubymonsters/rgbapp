class StateData < ActiveRecord::Migration[5.1]
  def change
    execute "update applications set state = 2 where selected"
    remove_column :applications, :selected
  end
end
