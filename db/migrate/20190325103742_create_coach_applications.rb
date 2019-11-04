class CreateCoachApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :coach_applications do |t|
      t.boolean :installationparty
      t.boolean :workshopday
      t.string :lightningtalk
      t.string :notes
      t.references :event, foreign_key: true
      t.references :coach, foreign_key: true
      t.timestamps
    end
  end
end
