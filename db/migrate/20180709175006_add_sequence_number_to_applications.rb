class AddSequenceNumberToApplications < ActiveRecord::Migration[5.1]
  def change
    add_column :applications, :sequence_number, :integer

    Event.all.each do |event|
      event.applications.each_with_index do |application, index|
        application.sequence_number = index + 1
        application.save!
      end
    end
  end
end
