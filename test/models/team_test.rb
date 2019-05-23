# == Schema Information
#
# Table name: teams
#
#  id                            :integer          not null, primary key
#  name                          :string(255)
#  number                        :integer
#  district                      :string(255)
#  stage                         :string(255)
#  ts_registered                 :datetime
#  ts_rules_submitted            :datetime
#  ts_about_submitted            :datetime
#  ts_departed                   :datetime
#  ts_arrived                    :datetime
#  participants_json             :text(65535)
#  points                        :integer
#  preference_departure          :string(255)
#  hotspot                       :integer
#  points_before_about           :integer
#  points_before_rules           :integer
#  points_before_register        :integer
#  points_survival_travel        :integer
#  points_survival_dinner        :integer
#  points_survival_night_spot    :integer
#  points_survival_night_tent    :integer
#  points_survival_night_cleanup :integer
#  points_survival_night_packing :integer
#  points_survival_night_gps     :integer
#  points_survival_night_moral   :integer
#  points_race_01                :integer
#  points_race_02                :integer
#  points_race_03                :integer
#  points_race_04                :integer
#  points_race_05                :integer
#  points_race_06                :integer
#  points_race_07                :integer
#  points_race_08                :integer
#  points_race_09                :integer
#  points_race_10                :integer
#  points_race_11                :integer
#  points_race_12                :integer
#  points_race_13                :integer
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  uid                           :string(255)
#  category                      :string(255)
#  about_photo_file_name         :string(255)
#  about_photo_content_type      :string(255)
#  about_photo_file_size         :bigint
#  about_photo_updated_at        :datetime
#  replies_register              :text(65535)
#  replies_rules                 :text(65535)
#  ts_rules_started              :datetime
#  ts_rules_done                 :datetime
#  initial_emails                :string(255)
#

require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
