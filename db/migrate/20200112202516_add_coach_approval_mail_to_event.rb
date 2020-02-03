class AddCoachApprovalMailToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :coach_approval_mail, :text
    add_column :events, :coach_approval_mail_subject, :text
  end
end
