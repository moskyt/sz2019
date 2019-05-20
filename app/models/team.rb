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
    (points_register_max+points_about_max+points_rules_max) + 4 * 36 + 13 * 36
  end

  def self.points_about_max
    48
  end

  def self.points_register_max
    18
  end

  def self.points_rules_max
    36
  end
  
  def self.available_transport_options(team)
    tx = Team.transport_choices.keys.dup
    Team.find_each do |t|
      unless t.id == team.id 
        tx.delete(t.preference_departure)
      end
    end
    tx
  end
  
  def self.transport_choices 
    {
      "vlak 1, HS 1"  =>  "odjezd 16:28 / 8km večer / 3km ráno",
      "vlak 1, HS 2"  =>  "odjezd 16:28 / 8km večer / 3km ráno",
      "vlak 1, HS 3"  =>  "odjezd 16:28 / 8km večer / 2km ráno",
      "vlak 1, HS 4"  =>  "odjezd 16:28 / 7km večer / 2km ráno",
      "vlak 1, HS 5"  =>  "odjezd 16:28 / 8km večer / 0km ráno",
      "vlak 2, HS 6"  =>  "odjezd 16:38 / 7km večer / 3km ráno",
      "vlak 2, HS 7"  =>  "odjezd 16:38 / 6km večer / 3km ráno",
      "vlak 2, HS 8"  =>  "odjezd 16:38 / 6km večer / 3km ráno",
      "vlak 2, HS 9"  =>  "odjezd 16:38 / 6km večer / 4km ráno",
      "vlak 2, HS 6"  =>  "odjezd 16:38 / 7km večer / 3km ráno",
      "vlak 3, HS 1"  =>  "odjezd 16:58 / 8km večer / 3km ráno",
      "vlak 3, HS 2"  =>  "odjezd 16:58 / 8km večer / 3km ráno",
      "vlak 3, HS 3"  =>  "odjezd 16:58 / 8km večer / 2km ráno",
      "vlak 3, HS 4"  =>  "odjezd 16:58 / 7km večer / 2km ráno",
      "vlak 3, HS 5"  =>  "odjezd 16:58 / 8km večer / 0km ráno",
      "vlak 3, HS 6"  =>  "odjezd 16:58 / 7km večer / 3km ráno",
      "vlak 4, HS 7"  =>  "odjezd 17:08 / 6km večer / 3km ráno",
      "vlak 4, HS 8"  =>  "odjezd 17:08 / 6km večer / 3km ráno",
      "vlak 4, HS 9"  =>  "odjezd 17:08 / 6km večer / 4km ráno",
      "vlak 4, HS 10" =>  "odjezd 17:08 / 6km večer / 4km ráno",
      "vlak 4, HS 1"  =>  "odjezd 17:08 / 8km večer / 3km ráno",
      "vlak 5, HS 7"  =>  "odjezd 17:28 / 6km večer / 3km ráno",
      "vlak 5, HS 3"  =>  "odjezd 17:28 / 8km večer / 2km ráno",
      "vlak 5, HS 4"  =>  "odjezd 17:28 / 7km večer / 2km ráno",
      "vlak 5, HS 9"  =>  "odjezd 17:28 / 6km večer / 4km ráno",
      "vlak 5, HS 10" =>  "odjezd 17:28 / 6km večer / 4km ráno",     
    }
  end

  def self.rules_questions
    [
      ["S jakým závodem se obrok střídá Svojsíkův závod?", "ZVAS"],
      ["Uveďte jeden až tři z hlavních cílů Svojsíkova závodu (svými slovy)", "fungování, využití, zpětná, motivace"],
      ["Kolik může být soutěžících v jedné postupové hlídce?", "4-8"],
      ["Uveďte tři z důvodů diskvalifikace.", "předpisy, bezpečnost, bojkot, pravidla, pomáhání"],
      ["Proč je zaveden tzv. Postupový klíč?", "Upravuje počet postupujících družin"],
      ["Co určuje vítězství hlídky v rámci kola?", "Nejvyšší počet bodů"],
      ["Kdo podává protest a komu?", "Rádce družinu hlavnímu rozhodčímu"],
      ["Na co se zaměřují disciplíny modulu závod?", "Spolupráce družiny a týmové řešení úkolů"],
      ["Kolik kol má Svojsíkův závod?", "3"],
      ["Po kom se jmenuje Svojsíkův závod? Kdo to byl?", "ABS"],
      ["Co je úkolem ústředního štábu SZ (svými slovy)", "pravidla, materiály+web, podoba KK, celostátní, rozhdování"],
      ["Uveďte dvě kategorie postupových hlídek.", "Chlapecká a dívčí"],
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
    (points_about || 0) + (points_rules || 0) + (points_register || 0)
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

  def should_grade_before_register?
    return false if points_register
    return true if !replies_register.blank?
    return true if Team.register_deadline < Time.now.to_datetime
    false
  end

  def should_grade_before_about?
    return false if points_about
    return true if about_photo.file?
    return true if Team.about_deadline < Time.now.to_datetime
    false
  end

end
