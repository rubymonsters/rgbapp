class AddColumnState < ActiveRecord::Migration[5.1]
  def change
    add_column :applications, :state, :integer, default: 0, null: false
    #TODO we need to migrate the selected column, for example: for rejected 0/selected 1/waiting list 2 
  end
end
