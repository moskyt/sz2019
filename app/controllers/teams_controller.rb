class TeamsController < ApplicationController
  
  def dashboard
    @team = Team.where(uid: params[:uid]).first
  end
  
end
