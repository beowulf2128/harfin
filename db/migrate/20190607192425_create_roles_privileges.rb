class CreateRolesPrivileges < ActiveRecord::Migration[5.1]
  def change
    create_join_table :roles, :privileges do |t|

    end
  end
end
