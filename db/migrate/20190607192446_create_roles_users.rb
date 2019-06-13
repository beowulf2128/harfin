class CreateRolesUsers < ActiveRecord::Migration[5.1]
  def change
    create_join_table :roles, :users do |t|
    end
  end
end
