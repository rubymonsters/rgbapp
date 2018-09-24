class AddSelectionMailToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :selection_mail, :text
  end
end
