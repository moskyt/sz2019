class RemoveBadFromTeams < ActiveRecord::Migration
  def change
    remove_column :teams, :hotspot, :integer
    remove_column :teams, :stage, :string
  end
end
