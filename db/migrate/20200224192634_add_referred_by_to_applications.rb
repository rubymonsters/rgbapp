class AddReferredByToApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :referred_by, :text
  end
end
