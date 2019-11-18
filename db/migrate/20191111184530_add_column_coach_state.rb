class AddColumnCoachState < ActiveRecord::Migration[5.2]
  def change
    add_column :coach_applications, :state, :integer, default: 0, null: false
  end
end
