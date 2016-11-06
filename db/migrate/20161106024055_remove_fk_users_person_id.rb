class RemoveFkUsersPersonId < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :users, column: :person_id
  end
end
