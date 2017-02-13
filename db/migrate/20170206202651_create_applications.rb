class CreateApplications < ActiveRecord::Migration[5.0]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :email
      t.boolean :language_de
      t.boolean :language_en
      t.boolean :attended_before
      t.boolean :rejected_before
      t.integer :level
      t.text :comments
      t.string :os
      t.boolean :needs_computer
      t.text :tutorials

      t.timestamps
    end
  end
end
