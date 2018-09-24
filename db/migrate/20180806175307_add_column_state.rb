class AddColumnState < ActiveRecord::Migration[5.1]
  def change
    add_column :applications, :state, :integer, default: 0, null: false
  end
end
