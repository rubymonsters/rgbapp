class AddConfirmationDeadlineToEvents < ActiveRecord::Migration[5.1]
  def change
		  add_column :events, :confirmation_deadline, :integer, null: false, default: 5
  end
end
