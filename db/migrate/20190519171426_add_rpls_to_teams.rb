class AddRplsToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :replies_register, :text
    add_column :teams, :replies_rules, :text
  end
end
