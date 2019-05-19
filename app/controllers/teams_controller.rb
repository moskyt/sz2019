class TeamsController < ApplicationController
  
  def dashboard
    @team = Team.where(uid: params[:uid]).first
  end
  
  def module_before
    @team = Team.where(uid: params[:uid]).first
  end
  
  def module_survival
    @team = Team.where(uid: params[:uid]).first
  end
  
  def module_race
    @team = Team.where(uid: params[:uid]).first
  end
  
  def module_results
    @team = Team.where(uid: params[:uid]).first
  end
  
end
