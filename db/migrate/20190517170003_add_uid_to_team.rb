class AddUidToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :uid, :string
  end
end
