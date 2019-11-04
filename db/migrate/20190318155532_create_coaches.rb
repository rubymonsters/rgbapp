class CreateCoaches < ActiveRecord::Migration[5.1]
  def change
    create_table :coaches do |t|

      t.string :name
      t.boolean :language_de
      t.boolean :language_en
      t.boolean :female
      t.boolean :notifications, default: false
      t.references :user, null: false

      t.timestamps
    end
  end
end
