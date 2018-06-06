class CreateAttendances < ActiveRecord::Migration[5.1]
  def change
    create_table :attendances do |t|
      t.integer :attender_id
      t.integer :sessionday_id
      t.integer :recorded_by_id

      t.timestamps
    end
    add_foreign_key :attendances, :persons, column: :attender_id
    add_foreign_key :attendances, :sessiondays, column: :sessionday_id
    add_foreign_key :attendances, :persons, column: :recorded_by_id

  end
end
