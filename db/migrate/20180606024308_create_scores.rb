class CreateScores < ActiveRecord::Migration[5.1]
  def change
    create_table :scores do |t|
      t.references :scoretype, scoretype: true, foreign_key: true
      t.integer :point_value
      t.references :sessionday, attendance: true, foreign_key: true
      t.date :score_date
      t.string  :team_name      # if the score applies to everyone on the team
      t.integer :clubber_id     # if the score applies to a single clubber
      t.integer :recorded_by_id

      t.timestamps
    end
    add_foreign_key :scores, :persons, column: :clubber_id
    add_foreign_key :scores, :persons, column: :recorded_by_id
  end
end
