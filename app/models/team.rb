# == Schema Information
#
# Table name: teams
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  number               :integer
#  district             :string(255)
#  stage                :string(255)
#  ts_registered        :datetime
#  ts_rules_submitted   :datetime
#  ts_about_submitted   :datetime
#  ts_departed          :datetime
#  ts_arrived           :datetime
#  participants_json    :text(65535)
#  points               :integer
#  points_about         :integer
#  points_rules         :integer
#  preference_departure :string(255)
#  preference_hotspot   :integer
#  departure            :string(255)
#  trail                :string(255)
#  hotspot              :integer
#  points_dinner        :integer
#  points_cleanup       :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  uid                  :string(255)
#  category             :string(255)
#  points_register      :integer
#  points_transport     :integer
#

class Team < ActiveRecord::Base
  
  before_save :set_uid, :eval_points
  
  def self.time0
    DateTime.new(2019, 5, 15, 12, 0, 0)    
  end
  
  def self.time1
    DateTime.new(2019, 6,  8, 12, 0, 0)
  end
  
  def self.time2
    DateTime.new(2019, 9, 15, 12, 0, 0)
  end
  
  def self.max_points
    (18+48+36+36) + 4 * 36 + 13 * 36
  end
  
  def time_end
    Team.time1 + points.to_f / Team.max_points * (Team.time2 - Team.time1) 
  end
  
  def time_left
    time_end - Time.now.to_datetime
  end
  
  def eval_points
    self.points = sum_before
  end
  
  def sum_before
    (points_transport || 0) + (points_about || 0) + (points_rules || 0) + (points_register || 0)
  end
  
  def set_uid    
    self.uid ||= begin
      require 'digest/md5'
      Digest::MD5.hexdigest("sz 2019 #{id}")[0..10]
    end
  end
  
end
