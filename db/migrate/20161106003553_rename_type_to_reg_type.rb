class RenameTypeToRegType < ActiveRecord::Migration[5.0]
  def change
    rename_column :registrations, :type, :reg_type

  end
end
