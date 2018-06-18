class AddApplicationMailToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :application_mail, :text
  end
end
