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

end
