# == Schema Information
#
# Table name: teams
#
#  id                       :integer          not null, primary key
#  name                     :string(255)
#  number                   :integer
#  district                 :string(255)
#  stage                    :string(255)
#  ts_registered            :datetime
#  ts_rules_submitted       :datetime
#  ts_about_submitted       :datetime
#  ts_departed              :datetime
#  ts_arrived               :datetime
#  participants_json        :text(65535)
#  points                   :integer
#  points_about             :integer
#  points_rules             :integer
#  preference_departure     :string(255)
#  preference_hotspot       :integer
#  departure                :string(255)
#  trail                    :string(255)
#  hotspot                  :integer
#  points_dinner            :integer
#  points_cleanup           :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  uid                      :string(255)
#  category                 :string(255)
#  points_register          :integer
#  points_transport         :integer
#  about_photo_file_name    :string(255)
#  about_photo_content_type :string(255)
#  about_photo_file_size    :bigint
#  about_photo_updated_at   :datetime
#  replies_register         :text(65535)
#  replies_rules            :text(65535)
#  ts_rules_started         :datetime
#

require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
