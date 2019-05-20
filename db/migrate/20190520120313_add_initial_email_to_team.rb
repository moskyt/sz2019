class AddInitialEmailToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :initial_emails, :string
  end
end
