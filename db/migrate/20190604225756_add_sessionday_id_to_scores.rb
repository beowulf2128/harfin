class AddSessiondayIdToScores < ActiveRecord::Migration[5.1]
  def change
    add_column :scores, :sessionday_id, :integer
  end
end
