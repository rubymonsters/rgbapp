class AddBlacklistedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :blacklisted, :boolean, default: false
  end
end
