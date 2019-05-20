class AddTsrsuToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :ts_rules_done, :datetime
  end
end
