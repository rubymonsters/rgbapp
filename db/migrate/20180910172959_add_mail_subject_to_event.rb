class AddMailSubjectToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :reminder_mail_subject, :text
    add_column :events, :application_mail_subject, :text
    add_column :events, :selection_mail_subject, :text
    add_column :events, :rejection_mail_subject, :text 
  end
end
