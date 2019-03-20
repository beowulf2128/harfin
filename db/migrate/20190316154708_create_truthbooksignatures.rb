class CreateTruthbooksignatures < ActiveRecord::Migration[5.1]
  def change
    create_table :truthbooksignatures do |t|
      t.integer :truthbooksection_id
      t.integer :sessionday_id
      t.integer :clubber_id

      t.timestamps
    end
  end
end
