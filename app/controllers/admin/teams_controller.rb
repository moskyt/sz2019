class Admin::TeamsController < Admin::AdminController
  
  def index
  end
  
  def new
    @team = Team.new
  end
  
  def show
    @team = Team.find(params[:id])
  end
    
  def edit
    @team = Team.find(params[:id])
  end
    
  def update
    @team = Team.find(params[:id])
    @team.update_attributes(params[:team])
    redirect_to action: :index
  end
    
end
