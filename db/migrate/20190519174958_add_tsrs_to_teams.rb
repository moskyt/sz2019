class AddTsrsToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :ts_rules_started, :datetime
  end
end
