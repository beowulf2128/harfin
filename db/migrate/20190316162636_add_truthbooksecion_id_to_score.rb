class AddTruthbooksecionIdToScore < ActiveRecord::Migration[5.1]
  def change
    add_column :scores, :truthbooksection_id, :integer
  end
end
