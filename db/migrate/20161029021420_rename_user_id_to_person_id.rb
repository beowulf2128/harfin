class RenameUserIdToPersonId < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :user_id, :person_id
  end
end
