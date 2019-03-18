class AddTruthbooksecionIdToScore < ActiveRecord::Migration[5.1]
  def change
    add_column :scores, :truthbooksignature_id, :integer
  end
end
