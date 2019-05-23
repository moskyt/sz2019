class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :number
      t.string :district
      t.string :stage
      t.datetime :ts_registered
      t.datetime :ts_rules_submitted
      t.datetime :ts_about_submitted
      t.datetime :ts_departed
      t.datetime :ts_arrived
      t.text :participants_json
      t.integer :points
      t.string :preference_departure
      t.integer :hotspot
      t.integer :points_before_about
      t.integer :points_before_rules
      t.integer :points_before_register
      t.integer :points_survival_travel
      t.integer :points_survival_dinner
      t.integer :points_survival_night_spot
      t.integer :points_survival_night_tent
      t.integer :points_survival_night_cleanup
      t.integer :points_survival_night_packing
      t.integer :points_survival_night_gps
      t.integer :points_survival_night_moral
      t.integer :points_race_01
      t.integer :points_race_02
      t.integer :points_race_03
      t.integer :points_race_04
      t.integer :points_race_05
      t.integer :points_race_06
      t.integer :points_race_07
      t.integer :points_race_08
      t.integer :points_race_09
      t.integer :points_race_10
      t.integer :points_race_11
      t.integer :points_race_12
      t.integer :points_race_13

      t.timestamps null: false
    end
  end
end
