class CreateScoretypes < ActiveRecord::Migration[5.1]
  def change
    create_table :scoretypes do |t|
      t.string :name
      t.integer :suggested_point_value
      t.boolean :active

      t.timestamps
    end
  end
end
