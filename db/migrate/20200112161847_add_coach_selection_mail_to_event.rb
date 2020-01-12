class AddCoachSelectionMailToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :coach_selection_mail, :text
    add_column :events, :coach_selection_mail_subject, :text
  end
end
