class AddPtregToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :points_register, :integer
    add_column :teams, :points_transport, :integer
  end
end
