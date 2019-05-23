class AddCheckinDataToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :checkin_data, :text
  end
end
