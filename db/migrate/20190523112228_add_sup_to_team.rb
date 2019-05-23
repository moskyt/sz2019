class AddSupToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :medical_data, :text
    add_column :teams, :new_supervisor_data, :text
  end
end
