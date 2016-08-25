class CreatePersons < ActiveRecord::Migration[5.0]
  def change
    create_table :persons do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.date :birthdate
      t.boolean :gender

      t.timestamps
    end
  end
end
