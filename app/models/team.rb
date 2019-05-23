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

class Team < ActiveRecord::Base

  before_save :set_uid, :eval_points
  has_attached_file :about_photo
  validates_attachment_content_type :about_photo, :content_type => ['application/pdf']

  RACEPOINTS = {
    1 =>  ["Na pile",                     36],
    2 =>  ["Redakce",                     36],
    3 =>  ["Logistické centrum",          36],
    4 =>  ["Čínská restaurace",           36],
    5 =>  ["Dispečink záchranné služby",  36],
    6 =>  ["Televizní stanice",           36],
    7 =>  ["scénická krize",              36],
    8 =>  ["Dopravní policie",            36],
    9 =>  ["Seznamovací agentura",        36],
    10 => ["Doručovací služba",           36],
    11 => ["Stavba?",                     36],
    12 => ["teoretická krize",            36],
    13 => ["1188",                        36],
  }

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
    points_before_max + 4 * 36 + RACEPOINTS.values.map{|x| x[1]}.inject(:+)
  end

  def self.points_before_max
    (points_before_register_max+points_before_about_max+points_before_rules_max)
  end

  def self.points_before_about_max
    48
  end

  def self.points_before_register_max
    18
  end

  def self.points_before_rules_max
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
      detail: "jáma s pařezem uprostřed"
    },
    2 => {
      name: "Křižovatka u Klondajku",
      lng: 14.1751272,
      lat: 49.8523947,
      detail: "jáma s pařezem uprostřed"
    },
    3 => {
      name: "Posed hřeben",
      lng: 14.1832092,
      lat: 49.8550206,
      detail: "posed s označením H2"
    },
    4 => {
      name: "Soudný",
      lng: 49.8603578,
      lat: 14.1937092,
      detail: "pata kříže"
    },
    5 => {
      name: "Seník na T",
      lng: 14.1914814,
      lat: 49.8527933,
      detail: "kanálek pod cestou (shora)"
    },
    6 => {
      name: "Buk u Čunčí",
      lng: 14.2014300,
      lat: 49.8628203,
      detail: "Buk v J rohu vysokého lesa"
    },
    7 => {
      name: "Vrážky",
      lng: 14.1952628,
      lat: 49.8644525,
      detail: "pařez s kládou napříč"
    },
    8 => {
      name: "Adamka",
      lng: 14.2081386,
      lat: 49.8694686,
      detail: "pařez na světlině na jižní cestě"
    },
    9 => {
      name: "Modřín mezi pasekami",
      lng: 14.2016056,
      lat: 49.8678608,
      detail: "modřín mezi pasekami"
    },
    10 => {
      name: "Rochoty",
      lng: 14.1930339,
      lat: 49.8702806,
      detail: "pod lavicí"
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
      "vlak 2, HS 1"  =>  "odjezd 16:38 / 7km večer / 3km ráno",
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

  def trail
    {
      "vlak 1, HS 1"  =>  "žlutá",
      "vlak 1, HS 2"  =>  "žlutá",
      "vlak 1, HS 3"  =>  "zelená",
      "vlak 1, HS 4"  =>  "zelená",
      "vlak 1, HS 5"  =>  "žlutá",
      "vlak 2, HS 6"  =>  "žlutá",
      "vlak 2, HS 7"  =>  "zelená",
      "vlak 2, HS 8"  =>  "zelená",
      "vlak 2, HS 9"  =>  "žlutá",
      "vlak 2, HS 1"  =>  "žlutá",
      "vlak 3, HS 1"  =>  "zelená",
      "vlak 3, HS 2"  =>  "zelená",
      "vlak 3, HS 3"  =>  "žlutá",
      "vlak 3, HS 4"  =>  "žlutá",
      "vlak 3, HS 5"  =>  "zelená",
      "vlak 3, HS 6"  =>  "zelená",
      "vlak 4, HS 7"  =>  "žlutá",
      "vlak 4, HS 8"  =>  "žlutá",
      "vlak 4, HS 9"  =>  "zelená",
      "vlak 4, HS 10" =>  "zelená",
      "vlak 4, HS 1"  =>  "žlutá",
      "vlak 5, HS 7"  =>  "žlutá",
      "vlak 5, HS 3"  =>  "zelená",
      "vlak 5, HS 4"  =>  "zelená",
      "vlak 5, HS 9"  =>  "žlutá",
      "vlak 5, HS 10" =>  "žlutá",
      }[preference_departure]
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
    points_survival_night_spot || points_survival_night_tent || points_survival_night_cleanup || points_survival_night_packing || points_survival_night_gps || points_survival_night_moral
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
    ss = ""
    s.chars.each do |c|
      ss += case c
      when "0".."9"
        ((c.to_i + 1)%10).to_s
      when "a".."z"
        c.upcase
      else
        c
      end
    end
    ss
  end

  def self.survival_to_uid(s)
    ss = ""
    s.chars.each do |c|
      ss += case c
      when "0".."9"
        ((c.to_i - 1)%10).to_s
      when "A".."Z"
        c.downcase
      else
        c
      end
    end
    ss
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
    return true if self.ts_rules_started and self.ts_rules_started + 30.minutes < Time.now.to_datetime
    false
  end

  def should_grade_before_register?
    return false if points_before_register
    return true if !replies_register.blank?
    return true if Team.register_deadline < Time.now.to_datetime
    false
  end

  def should_grade_before_about?
    return false if points_before_about
    return true if about_photo.file?
    return true if Team.about_deadline < Time.now.to_datetime
    false
  end

end
