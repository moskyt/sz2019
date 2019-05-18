class Admin::TeamsController < Admin::AdminController
  
  def index
  end
  
  def new
    @team = Team.new
  end
  
  def show
    @team = Team.find(params[:id])
  end
  
end
