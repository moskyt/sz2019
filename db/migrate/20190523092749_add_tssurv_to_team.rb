class AddTssurvToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :ts_survival_center, :datetime
    add_column :teams, :ts_survival_hotspot, :datetime
  end
end
