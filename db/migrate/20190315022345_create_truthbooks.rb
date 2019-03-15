class CreateTruthbooks < ActiveRecord::Migration[5.1]
  def change
    create_table :truthbooks do |t|
      t.string :name
      t.string :edition

      t.timestamps
    end
  end
end
