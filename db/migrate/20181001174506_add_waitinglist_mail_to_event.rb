class AddWaitinglistMailToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :waiting_list_mail, :text
    add_column :events, :waiting_list_mail_subject, :text
  end
end
