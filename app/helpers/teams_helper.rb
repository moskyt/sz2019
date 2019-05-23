module TeamsHelper

  def time_widget(team)
    sss = team.time_left
    d = sss.floor
    h = ((sss          ).frac * 24).floor
    m = ((sss * 24     ).frac * 60).floor
    s = ((sss * 24 * 60).frac * 60).floor

    content_tag :span, class: "time-widget", data: {team_id: team.id, d: d, h: h, m: m, s: s, n: 0} do
      (content_tag :span, class: "points" do
        "#{team.points} b"
      end) + " | " +
      (content_tag :span, class: "time" do
        format_time_left(sss)
      end)
    end
  end

end
