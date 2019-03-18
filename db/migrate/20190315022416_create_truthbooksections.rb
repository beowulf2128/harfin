class CreateTruthbooksections < ActiveRecord::Migration[5.1]
  def change
    create_table :truthbooksections do |t|
      t.string :unit
      t.string :section
      t.integer :sort
      t.integer :truthbook_id

      t.timestamps
    end
  end
end
