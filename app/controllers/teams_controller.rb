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
  
  def before_rules_start
    @team = Team.where(uid: params[:uid]).first
  end
  
  def before_rules_go
    @team = Team.where(uid: params[:uid]).first
    # set start
    @team.update_attribute :ts_rules_started, Time.now
    # redirect to questions
    redirect_to before_rules_questions_team_path(uid: @team.uid)
  end

  def before_rules_questions
    @team = Team.where(uid: params[:uid]).first
  end
  
  def before_rules_submit
    @team = Team.where(uid: params[:uid]).first
    
  end
  
end
