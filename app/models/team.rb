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

class Team < ActiveRecord::Base

  before_save :set_uid, :eval_points
  has_attached_file :about_photo
  validates_attachment_content_type :about_photo, :content_type => ['application/pdf']

  def self.time0
    DateTime.civil_from_format(:local, 2019, 5, 15, 12, 0, 0)
  end

  def self.time1
    DateTime.civil_from_format(:local, 2019, 6, 10, 12, 0, 0)
  end

  def self.time2
    DateTime.civil_from_format(:local, 2019, 9, 15, 12, 0, 0)
  end

  def self.about_deadline
    DateTime.civil_from_format(:local, 2019, 6, 3, 20, 0, 0)
  end

  def self.rules_deadline
    DateTime.civil_from_format(:local, 2019, 6, 3, 12, 0, 0)
  end

  def self.register_deadline
    DateTime.civil_from_format(:local, 2019, 5, 27, 22, 0, 0)
  end

  def self.max_points
    (points_register_max+points_transport_max+points_about_max+points_rules_max) + 4 * 36 + 13 * 36
  end

  def self.points_about_max
    48
  end

  def self.points_register_max
    18
  end

  def self.points_transport_max
    36
  end

  def self.points_rules_max
    36
  end

  def self.rules_questions
    [
      ["Kolik je na světě myší?","13"],
      ["Jsou psi jeleni?","dva"],
      ["Má pivo pivo?","ne"],
      ["Kdo se nakrájel pozítří?","trochu asi"],
      ["Kdo je moje stáří?","já"],
      ["Smí shnilci do ulic?","vždycky"],
      ["Je existence zrušena?","napořád"],
    ]
  end

  def self.time_per_point
    # 1 / Team.max_points.to_f * (Team.time2 - Team.time1)
    3.0 / 24.0
  end

  def time_end
    Team.time1 + points.to_f * Team.time_per_point
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
      if id
        require 'digest/md5'
        Digest::MD5.hexdigest("sz 2019 #{id}")[0..10]
      else
        nil
      end
    end
  end

  def replies_rules_
    if replies_rules.blank?
      {}
    else
      JSON[replies_rules]
    end
  end

  def replies_register_
    if replies_register.blank?
      {}
    else
      JSON[replies_register]
    end
  end
  
  def should_grade_before_rules?
    return false if points_rules
    return true if !replies_rules.blank?
    return true if Team.rules_deadline < Time.now.to_datetime
    return true if self.ts_rules_started and self.ts_rules_started + 30.minutes < Time.now.to_datetime
    false
  end

end
