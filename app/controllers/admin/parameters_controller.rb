class Admin::ParametersController < Admin::AdminController
  
  def index
    #
  end
  
  def update
    Parameter[params[:key]] = params[:value]
    redirect_to action: :index
  end
  
end
