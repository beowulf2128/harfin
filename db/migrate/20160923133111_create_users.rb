class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.datetime :last_login_at
      t.references :user, user: true, foreign_key: true

      t.timestamps
    end
  end
end
