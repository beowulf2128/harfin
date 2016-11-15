class AddisClubNightToSessiondays < ActiveRecord::Migration[5.0]
  def change
    add_column :sessiondays, :is_club_night, :boolean
  end
end
