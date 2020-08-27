class RenameBlacklistedToIsBlocked < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :blacklisted, :is_blocked
  end
end
