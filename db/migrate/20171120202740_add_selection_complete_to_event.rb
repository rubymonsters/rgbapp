class AddSelectionCompleteToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :selection_complete, :boolean, :null => false, :default => false
  end
end
