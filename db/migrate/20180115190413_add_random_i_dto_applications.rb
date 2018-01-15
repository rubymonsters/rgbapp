class AddRandomIDtoApplications < ActiveRecord::Migration[5.1]
  def change
    add_column :applications, :random_id, :string
  end
end
