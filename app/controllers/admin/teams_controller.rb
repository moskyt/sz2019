class Admin::TeamsController < Admin::AdminController

  skip_before_action :http_basic_authenticate, only: [:survival_backup]
  
  def index
  end
  
  def survival_backup
    respond_to do |format|
      format.pdf do
        response.headers['Content-Disposition'] = "inline; filename=\"sz2019_preziti.pdf\""
        render :layout => true
      end
    end
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
        unless tx.empty? or tx.reject(&:blank?).empty?
          Team.find(tid).update_attribute :points_before_rules, tx.map(&:to_i).inject(0,:+)
        end
      end
      redirect_to action: :before
    end
  end

  def grade_before_about
    if request.post?
      params["points_about"].each do |tid, tx|
        unless tx.empty? or tx.reject(&:blank?).empty?
          Team.find(tid).update_attribute :points_before_about, tx.map(&:to_i).inject(0,:+)
        end
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


  def send_links
    flash[:notice] = "pos..áno"
    Team.find_each do |t|
      InfoMailer.initial_links_email(t).deliver
    end
    redirect_to action: :index
  end

end
