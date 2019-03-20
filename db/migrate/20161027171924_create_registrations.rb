class CreateRegistrations < ActiveRecord::Migration[5.0]
  def change
    create_table :registrations do |t|
      t.boolean :registered
      t.string :type
      t.string :group_assignment
      t.string :table_assignment
      t.string :team_name
      t.references :person, person: true, foreign_key: true
      t.references :sessionyear, sessionyear: true, foreign_key: true

      t.timestamps
    end
  end
end
