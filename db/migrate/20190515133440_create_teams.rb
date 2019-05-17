class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :number
      t.integer :district
      t.string :stage
      t.datetime :ts_registered
      t.datetime :ts_rules_submitted
      t.datetime :ts_about_submitted
      t.datetime :ts_departed
      t.datetime :ts_arrived
      t.text :participants_json
      t.integer :points
      t.integer :points_about
      t.integer :points_rules
      t.string :preference_departure
      t.integer :preference_hotspot
      t.string :departure
      t.string :trail
      t.integer :hotspot
      t.integer :points_dinner
      t.integer :points_cleanup

      t.timestamps null: false
    end
  end
end
