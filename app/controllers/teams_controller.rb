class TeamsController < ApplicationController

  before_filter :load_team

  def dashboard
<<<<<<< Updated upstream
  end

  def info
  end

  def module_before
  end

  def module_survival
  end

  def module_race
  end

  def module_results
  end

  def before_rules_start
  end

  def before_register
=======
    @team = Team.where(uid: params[:uid]).first or redirect_to :root
  end

  def info
    @team = Team.where(uid: params[:uid]).first or redirect_to :root
  end

  def module_before
    @team = Team.where(uid: params[:uid]).first or redirect_to :root
  end

  def module_survival
    @team = Team.where(uid: params[:uid]).first or redirect_to :root
  end

  def module_race
    @team = Team.where(uid: params[:uid]).first or redirect_to :root
  end

  def module_results
    @team = Team.where(uid: params[:uid]).first or redirect_to :root
  end

  def before_rules_start
    @team = Team.where(uid: params[:uid]).first or redirect_to :root
  end

  def before_register
    @team = Team.where(uid: params[:uid]).first or redirect_to :root
>>>>>>> Stashed changes
    @data = @team.replies_register_
  end

  def before_register_submit
<<<<<<< Updated upstream
=======
    @team = Team.where(uid: params[:uid]).first or redirect_to :root
>>>>>>> Stashed changes
    @team.update_attribute :replies_register, params[:register].to_json
    preference_departure = params[:preference_departure]
    if Team.available_transport_options(@team).include?(preference_departure)
      flash[:notice] = "Přihláška uložena."
      @team.update_attribute :preference_departure, preference_departure
      redirect_to module_before_team_path(uid: @team.uid)
    else
      flash[:error] = "Vybraný odjezd/cíl mezitím vybral někdo jiný, zkus to znovu."
      @data = @team.replies_register_
      @team.preference_departure = nil
      render :before_register
    end
  end

  def before_rules_go
<<<<<<< Updated upstream
=======
    @team = Team.where(uid: params[:uid]).first or redirect_to :root
>>>>>>> Stashed changes
    unless @team.ts_rules_started
      # set start
      @team.ts_rules_started = Time.now
      @team.save
    end
    if @team.ts_rules_started + 30.minutes > Time.now
      # redirect to questions
      redirect_to before_rules_questions_team_path(uid: @team.uid)
    else
      # redirect to questions
      redirect_to before_rules_expired_team_path(uid: @team.uid)
    end
  end

  def before_rules_done
<<<<<<< Updated upstream
=======
    @team = Team.where(uid: params[:uid]).first or redirect_to :root
>>>>>>> Stashed changes
    @team.update_attribute :ts_rules_done, Time.now.to_datetime
  end

  def before_rules_expired
<<<<<<< Updated upstream
=======
    @team = Team.where(uid: params[:uid]).first or redirect_to :root
>>>>>>> Stashed changes
    @team.update_attribute :ts_rules_done, Time.now.to_datetime
    # save or ...
  end

  def before_rules_questions
<<<<<<< Updated upstream
=======
    @team = Team.where(uid: params[:uid]).first or redirect_to :root
>>>>>>> Stashed changes
    unless @team.ts_rules_started
      # set start
      @team.ts_rules_started = Time.now
      @team.save
    end

    if @team.ts_rules_started + 30.minutes < Time.now
      redirect_to before_rules_expired_team_path(uid: @team.uid)
      return
    end

    @data = @team.replies_rules_
    @n = (params[:n] || 1).to_i
    @nn = Team.rules_questions.size
    if request.post?
      @data["q#{@n}"] = params[:reply]
      @team.update_attribute :replies_rules, @data.to_json
      if params[:next] and @n < @nn
        @n += 1
      elsif params[:prev] and @n > 1
        @n -= 1
      elsif params[:close]
        redirect_to before_rules_done_team_path(uid: @team.uid)
      end
    end
    @r = @data["q#{@n}"]
  end

  def before_about_ok
<<<<<<< Updated upstream
  end

  def before_about_failed
  end

  def before_about_upload
=======
    @team = Team.where(uid: params[:uid]).first or redirect_to :root
  end

  def before_about_failed
    @team = Team.where(uid: params[:uid]).first or redirect_to :root
  end

  def before_about_upload
    @team = Team.where(uid: params[:uid]).first or redirect_to :root
>>>>>>> Stashed changes
    if params[:about_pdf]
      @team.about_photo = params[:about_pdf]
      if @team.save
        redirect_to before_about_ok_team_path(uid: @team.uid)
      else
        redirect_to before_about_failed_team_path(uid: @team.uid)
      end
    else
      redirect_to before_about_failed_team_path(uid: @team.uid)
    end
  end

  protected

  def load_team
    @team = Team.where(uid: params[:uid]).first
    if @team
      true
    else
      redirect_to :root
      false
    end
  end


end
