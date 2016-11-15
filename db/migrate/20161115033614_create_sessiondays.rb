class CreateSessiondays < ActiveRecord::Migration[5.0]
  def change
    create_table :sessiondays do |t|
      t.references :sessionyear, sessionyear: true, foreign_key: true
      t.datetime :sd_date

      t.timestamps
    end
  end
end
