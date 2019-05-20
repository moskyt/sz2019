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
  
  def grade_before_rules
    if request.post?
      params["points_rules"].each do |tid, tx|
        Team.find(tid).update_attribute :points_rules, tx.map(&:to_i).inject(0,:+)
      end
      redirect_to action: :before
    end
  end
  
  def grade_before_register
    if request.post?
      params["points_register"].each do |tid, tx|
        Team.find(tid).update_attribute :points_register, tx.map(&:to_i).inject(0,:+)
      end
      redirect_to action: :before
    end
  end
    
end
