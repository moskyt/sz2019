class Admin::RaceController < ApplicationController

  layout "race"

  def point
    @racepoint = Team.uid_to_racepoint(params[:rpuid])
    max = Team::RACEPOINTS[@racepoint][1]
    if request.post?
      if params[:points] and params[:points].size == 1 and !params[:points].values[0].blank?
        tid = params[:points].keys[0].to_i
        pts = params[:points].values[0].to_i
        @team = Team.find(tid)
        if pts >= 0 and pts <= max
          @team.update_attribute("points_race_%02d" % @racepoint, pts)
          flash[:notice] = "#{@team.name} -- #{pts} / #{max} b"
        else
          flash[:error] = "Nejde nastavit body - #{params[:points].values[0].inspect} je mimo rozsah 0 - #{max}"
        end
      else
        flash[:error] = "Nejde nastavit body - #{params[:points].inspect}"
      end
      respond_to do |format|
        format.html do
          redirect_to race_point_url(rpuid: Team.racepoint_uid(@racepoint))
        end
        format.js do
          flash.discard
          render
        end
      end
    end
  end

end
