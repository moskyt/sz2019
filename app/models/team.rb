# == Schema Information
#
# Table name: teams
#
#  id                            :integer          not null, primary key
#  name                          :string(255)
#  number                        :integer
#  district                      :string(255)
#  ts_registered                 :datetime
#  ts_rules_submitted            :datetime
#  ts_about_submitted            :datetime
#  ts_departed                   :datetime
#  ts_arrived                    :datetime
#  participants_json             :text(65535)
#  points                        :integer
#  preference_departure          :string(255)
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
#  ts_survival_center            :datetime
#  ts_survival_hotspot           :datetime
#  checkin_photo_file_name       :string(255)
#  checkin_photo_content_type    :string(255)
#  checkin_photo_file_size       :bigint
#  checkin_photo_updated_at      :datetime
#  checkin_data                  :text(65535)
#  medical_data                  :text(65535)
#  new_supervisor_data           :text(65535)
#

class Team < ActiveRecord::Base

  before_save :set_uid, :eval_points
  has_attached_file :about_photo
  validates_attachment_content_type :about_photo, :content_type => ['application/pdf']
  has_attached_file :checkin_photo
  validates_attachment_content_type :checkin_photo, :content_type => /image/

  RACEPOINTS = {
    1 =>  ["Televizní stanice", 36],
    2 =>  ["Přijímací pohovor do dispečinku záchranky", 36],
    3 =>  ["Redakce", 36],
    4 =>  ["Stavba", 36],
    5 =>  ["Call centrum", 36],
    6 =>  ["Seznamovací agentura", 36],
    7 =>  ["Doručovací služba", 36],
    8 =>  ["Cykloškola", 36],
    9 =>  ["Na pile", 36],
    10 => ["Truhlářská dílna", 36],
    11 => ["Logistické centrum", 36],
    12 => ["Čínská restaurace", 36],
    13 => ["Autobus", 36],
  }

  def clear_everything_this_is_dangerous!
    update_attributes({
      ts_registered: nil,
      ts_rules_submitted: nil,
      ts_about_submitted: nil,
      ts_departed: nil,
      ts_arrived: nil,
      participants_json: nil,
      points: nil,
      preference_departure: nil,
      points_before_about: nil,
      points_before_rules: nil,
      points_before_register: nil,
      points_survival_travel: nil,
      points_survival_dinner: nil,
      points_survival_night_spot: nil,
      points_survival_night_tent: nil,
      points_survival_night_cleanup: nil,
      points_survival_night_packing: nil,
      points_survival_night_gps: nil,
      points_survival_night_moral: nil,
      points_race_01: nil,
      points_race_02: nil,
      points_race_03: nil,
      points_race_04: nil,
      points_race_05: nil,
      points_race_06: nil,
      points_race_07: nil,
      points_race_08: nil,
      points_race_09: nil,
      points_race_10: nil,
      points_race_11: nil,
      points_race_12: nil,
      points_race_13: nil,
      about_photo_file_name: nil,
      about_photo_content_type: nil,
      about_photo_file_size: nil,
      about_photo_updated_at: nil,
      replies_register: nil,
      replies_rules: nil,
      ts_rules_started: nil,
      ts_rules_done: nil,
      ts_survival_center: nil,
      ts_survival_hotspot: nil,
      checkin_photo_file_name: nil,
      checkin_photo_content_type: nil,
      checkin_photo_file_size: nil,
      checkin_photo_updated_at: nil,
      checkin_data: nil,
      medical_data: nil,
      new_supervisor_data: nil,
    })
  end

  def self.time0
    DateTime.civil_from_format(:local, 2019, 5, 15, 12, 0, 0)
  end

  def self.time1
    DateTime.civil_from_format(:local, 2019, 6,  8,  8, 0, 0)
  end

  def self.time2
    DateTime.civil_from_format(:local, 2019, 9, 15, 12, 0, 0)
  end

  def self.about_deadline
    DateTime.civil_from_format(:local, 2019, 6, 7, 12, 0, 0)
  end

  def self.rules_deadline
    DateTime.civil_from_format(:local, 2019, 6, 7, 12, 0, 0)
  end

  def self.register_deadline
    DateTime.civil_from_format(:local, 2019, 6, 6, 23, 59, 0)
  end

  def self.max_points
    points_before_max + points_survival_max + points_race_max
  end

  def self.points_race_max
    RACEPOINTS.values.map{|x| x[1]}.inject(:+)
  end

  def self.points_before_max
    (points_before_register_max+points_before_about_max+points_before_rules_max)
  end

  def self.points_before_about_max
    48
  end

  def self.points_before_register_max
    0
  end

  def self.points_before_rules_max
    36
  end

  def self.points_survival_travel_max
    36
  end

  def self.points_survival_dinner_max
    36
  end

  def self.points_survival_night_spot_max
    18
  end

  def self.points_survival_night_tent_max
    36
  end

  def self.points_survival_night_cleanup_max
    36
  end

  def self.points_survival_night_packing_max
    36
  end

  def self.points_survival_night_gps_max
    36
  end

  def self.points_survival_night_moral_max
    36
  end

  def self.points_survival_night_max
    points_survival_night_spot_max + points_survival_night_tent_max + points_survival_night_cleanup_max + points_survival_night_packing_max + points_survival_night_gps_max + points_survival_night_moral_max
  end

  def self.points_survival_max
    points_survival_travel_max + points_survival_dinner_max + points_survival_night_max
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

  TRAINS = {
    1 => {
      departure: "16:28",
      arrival: "16:52",
      number: "Os 8852",
    },
    2 => {
      departure: "16:38",
      arrival: "17:03",
      number: "Os 9954",
    },
    3 => {
      departure: "16:58",
      arrival: "17:22",
      number: "Os 8854",
    },
    4 => {
      departure: "17:08",
      arrival: "17:33",
      number: "Os 9956",
    },
    5 => {
      departure: "17:28",
      arrival: "17:52",
      number: "Os 8856",
    },
  }

  HOTSPOTS = {
    1 => {
      name: "Vrahův kemp",
      lng: 14.1813342,
      lat: 49.8618503,
      detail: "pod lavicí v kempu",
      km: [8,3],
    },
    2 => {
      name: "Křižovatka u Klondajku",
      lng: 14.1751272,
      lat: 49.8523947,
      detail: "jáma s pařezem uprostřed",
      km: [8,3],
    },
    3 => {
      name: "Posed na hřebeni",
      lng: 14.1832092,
      lat: 49.8550206,
      detail: "posed s označením H2",
      km: [8,2],
    },
    4 => {
      name: "Soudný",
      lng: 14.1937092,
      lat: 49.8603578,
      detail: "pata kříže",
      km: [7,2],
    },
    5 => {
      name: "Seník na T",
      lng: 14.1914814,
      lat: 49.8527933,
      detail: "kanálek pod cestou (shora)",
      km: [9,0],
    },
    6 => {
      name: "Buk u Čunčí",
      lng: 14.2014300,
      lat: 49.8628203,
      detail: "Buk v J rohu vysokého lesa",
      km: [7,3],
    },
    7 => {
      name: "Vrážky",
      lng: 14.1952628,
      lat: 49.8644525,
      detail: "pařez s kládou napříč",
      km: [6,3],
    },
    8 => {
      name: "Adamka",
      lng: 14.2081386,
      lat: 49.8694686,
      detail: "pařez na světlině na jižní cestě",
      km: [6,3],
    },
    9 => {
      name: "Modřín mezi pasekami",
      lng: 14.2016056,
      lat: 49.8678608,
      detail: "modřín mezi pasekami",
      km: [6,4],
    },
    10 => {
      name: "Rochoty",
      lng: 14.1930339,
      lat: 49.8702806,
      detail: "pod lavicí",
      km: [6,4],
    },
  }

  def train
    if m = self.preference_departure&.match(/^vlak (\d+), HS (\d+)$/)
      n = m[1].to_i
      {number: n}.merge(TRAINS[n])
    end
  end

  def hotspot
    if m = self.preference_departure&.match(/^vlak (\d+), HS (\d+)$/)
      n = m[2].to_i
      {number: n}.merge(HOTSPOTS[n])
    end
  end

  def self.transport_choices_set
    # train, hotspot
    [
      [1, 1 ],
      [1, 2 ],
      [1, 3 ],
      [1, 4 ],
      [1, 5 ],
      [2, 6 ],
      [2, 7 ],
      [2, 8 ],
      [2, 9 ],
      [2, 1 ],
      [3, 1 ],
      [3, 2 ],
      [3, 3 ],
      [3, 4 ],
      [3, 5 ],
      [3, 6 ],
      [4, 7 ],
      [4, 8 ],
      [4, 9 ],
      [4, 10],
      [4, 1 ],
      [5, 7 ],
      [5, 3 ],
      [5, 4 ],
      [5, 9 ],
      [5, 10],
    ]
  end

  def self.transport_choices
    m = {}
    Team.transport_choices_set.each do |tn, hs|
      t = TRAINS[tn]
      h = HOTSPOTS[hs]
      m["vlak #{tn}, HS #{hs}"] = "odjezd #{t[:departure]} / #{h[:km][0]}km večer / #{h[:km][1]}km ráno"
    end
    m
  end

  def trail
    return nil unless preference_departure
    i = Team.transport_choices.keys.index(preference_departure)
    return nil unless i
    i % 4 < 2 ? "žlutá" : "zelená"
  end

  def self.rules_minutes
    20
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
    self.points = sum_before + sum_survival + sum_race
  end

  def sum_before
    (points_before_about || 0) + (points_before_rules || 0) + (points_before_register || 0)
  end

  def sum_survival
    (points_survival_travel || 0) + (points_survival_dinner || 0) +
    sum_survival_night
  end

  def sum_survival_night
    (points_survival_night_spot || 0) + (points_survival_night_tent || 0) + (points_survival_night_cleanup || 0) + (points_survival_night_packing || 0) + (points_survival_night_gps || 0) + (points_survival_night_moral || 0)
  end

  def points_survival_night
    (points_survival_night_spot || points_survival_night_tent || points_survival_night_cleanup || points_survival_night_packing || points_survival_night_gps || points_survival_night_moral) ? sum_survival_night : nil
  end

  def sum_race
    RACEPOINTS.keys.map do |i|
      self.send("points_race_%02d" % i) || 0
    end.inject(:+)
  end

  def self.racepoint_uid(i)
    "%08x" % (i ** 7 + 7981375)
  end

  def self.uid_to_racepoint(x)
    ((x.to_i(16) - 7981375) ** (1.0/7)).round
  end

  def self.hotspot_uid(i)
    "%08x" % (i ** 6 + 5080981)
  end

  def self.uid_to_hotspot(x)
    ((x.to_i(16) - 5080981) ** (1.0/6)).round
  end

  def self.center_uid
    "f0f0b1b1"
  end

  def self.uid_to_survival(s)
    s + "HPS"
    # ss = ""
    # s.chars.each do |c|
    #   ss += case c
    #   when "0".."9"
    #     ((c.to_i + 1)%10).to_s
    #   when "a".."z"
    #     c.upcase
    #   else
    #     c
    #   end
    # end
    # ss
  end

  def self.survival_to_uid(s)
    s[-3..-1] == "HPS" ? s[0...-3] : nil
    # ss = ""
    # s.chars.each do |c|
    #   ss += case c
    #   when "0".."9"
    #     ((c.to_i - 1)%10).to_s
    #   when "A".."Z"
    #     c.downcase
    #   else
    #     c
    #   end
    # end
    # ss
  end

  def survival_uid
    Team.uid_to_survival(uid)
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
    return false if points_before_rules
    return true if !replies_rules.blank?
    return true if Team.rules_deadline < Time.now.to_datetime
    return true if self.ts_rules_started and self.ts_rules_started + Team.rules_minutes.minutes < Time.now.to_datetime
    false
  end

  def should_grade_before_register?
    # return false if points_before_register
    # return true if !replies_register.blank?
    # return true if Team.register_deadline < Time.now.to_datetime
    false
  end

  def should_grade_before_about?
    return false if points_before_about
    return true if about_photo.file?
    return true if Team.about_deadline < Time.now.to_datetime
    false
  end

end
