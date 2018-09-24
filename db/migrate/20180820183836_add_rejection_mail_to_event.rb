class AddRejectionMailToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :rejection_mail, :text
  end
end
