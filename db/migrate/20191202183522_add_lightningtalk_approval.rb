class AddLightningtalkApproval < ActiveRecord::Migration[5.2]
  def change
    add_column :coach_applications, :lightningtalk_approved, :boolean, default: false
  end
end
