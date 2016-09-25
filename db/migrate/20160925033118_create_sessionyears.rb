class CreateSessionyears < ActiveRecord::Migration[5.0]
  def change
    create_table :sessionyears do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.string :theme

      t.timestamps
    end
  end
end
