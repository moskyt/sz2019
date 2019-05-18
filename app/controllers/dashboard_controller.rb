class DashboardController < ApplicationController
  
  def update_time_widget
    @team = Team.find(params[:id])
    respond_to do |format|
      format.js do
        render text: view_context.time_widget(@team)
      end
    end
  end
  
end
