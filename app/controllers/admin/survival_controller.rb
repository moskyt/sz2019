class Admin::SurvivalController < ApplicationController

  layout "survival"

  before_filter :load_team

  def load_team
    @team = Team.where(uid: Team.survival_to_uid(params[:suid])).first
    if @team
      true
    else
      redirect_to :root
      false
    end
  end

  def supervisor
    if request.patch?
      @team.update_attribute :new_supervisor_data, params.dig(:team, :new_supervisor_data)
    end
  end

  def travel
    if request.patch?
      @team.update_attribute :points_survival_travel, params.dig(:team, :points_survival_travel)
      @team.update_attribute :medical_data, params.dig(:team, :medical_data)
    end
  end

  def dinner
    if request.patch?
      @team.update_attribute :points_survival_dinner, params.dig(:team, :points_survival_dinner)
    end
  end

end
