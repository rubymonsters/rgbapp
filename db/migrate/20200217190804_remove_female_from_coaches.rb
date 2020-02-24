class RemoveFemaleFromCoaches < ActiveRecord::Migration[5.2]
  def change
    remove_column :coaches, :female, :boolean
  end
end
