class Admin::RaceController < ApplicationController

  layout "race"

  def point
    @racepoint = Team.uid_to_racepoint(params[:rpuid])
    max = Team::RACEPOINTS[@racepoint][1]
    if request.post?
      if params[:points] and params[:points].size == 1
        tid = params[:points].keys[0].to_i
        pts = params[:points].values[0].to_i
        team = Team.find(tid)
        if pts >= 0 and pts <= max
          team.update_attribute("points_race_%02d" % @racepoint, pts)
          flash[:notice] = "#{team.name} -- #{pts} / #{max} b"
        else
          flash[:error] = "Nejde nastavit body - #{params.inspect}"
        end
      else
        flash[:error] = "Nejde nastavit body - #{params.inspect}"
      end
    end
  end

end
