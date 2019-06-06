class AddOvrtsToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :ts_checkin_override, :datetime
    add_column :teams, :ts_hotspot_override, :datetime
  end
end
