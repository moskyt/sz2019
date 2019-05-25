class TeamsController < ApplicationController

  before_filter :load_team, except: [:checkin_hotspot, :checkin_center]
  before_filter :pop_team, only: [:checkin_hotspot, :checkin_center]

  def checkin_hotspot
    huid = params[:huid]
    hotspot_number = huid && Team.uid_to_hotspot(huid)
    if @team.hotspot and (hotspot_number == @team.hotspot[:number])
      if request.post?
        flash[:notice] = "Potvrzen příchod na hotspot."
        @team.ts_survival_hotspot ||= Time.now
        @team.save
        redirect_to module_survival_team_url(uid: @team.uid)
      end
    else
      flash[:error] = "Špatné UID hotspotu."
      redirect_to dashboard_url(uid: @team.uid)
    end
  end

  def checkin_center
    cid = params[:cid]
    if cid == Team.center_uid
      if request.post?
        flash[:notice] = "Potvrzen příchod na shromaždiště. Modul přežití máte za sebou!"
        @team.ts_survival_center ||= Time.now
        @team.save
        redirect_to module_race_team_url(uid: @team.uid)
      end
    else
      flash[:error] = "Špatné UID shromaždiště."
      redirect_to dashboard_url(uid: @team.uid)
    end
  end

  def dashboard
  end

  def info
  end

  def module_intro
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
    @data = @team.replies_register_
  end

  def before_register_submit
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
    unless @team.ts_rules_started
      # set start
      @team.ts_rules_started = Time.now
      @team.save
    end
    if @team.ts_rules_started + Team.rules_minutes.minutes > Time.now
      # redirect to questions
      redirect_to before_rules_questions_team_path(uid: @team.uid)
    else
      # redirect to questions
      redirect_to before_rules_expired_team_path(uid: @team.uid)
    end
  end

  def before_rules_done
    @team.update_attribute :ts_rules_done, Time.now.to_datetime
  end

  def before_rules_expired
    @team.update_attribute :ts_rules_done, Time.now.to_datetime
    # save or ...
  end

  def before_rules_questions
    unless @team.ts_rules_started
      # set start
      @team.ts_rules_started = Time.now
      @team.save
    end

    if @team.ts_rules_started + Team.rules_minutes.minutes < Time.now
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
  end

  def before_about_failed
  end

  def before_about_upload
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

  def survival_checkin_ok
  end

  def survival_checkin_failed
  end

  def survival_checkin_upload
    if params[:checkin_photo] and params[:checkin_data]
      @team.checkin_photo = params[:checkin_photo]
      @team.checkin_data = params[:checkin_data]
      if @team.save
        redirect_to survival_checkin_ok_team_path(uid: @team.uid)
      else
        redirect_to survival_checkin_failed_team_path(uid: @team.uid)
      end
    else
      redirect_to survival_checkin_failed_team_path(uid: @team.uid)
    end
  end

  protected

  def load_team
    @team = Team.where(uid: params[:uid]).first
    if @team
      session[:team_uid] = @team.uid
      true
    else
      redirect_to :root
      false
    end
  end

  def pop_team
    if session[:team_uid] and (@team = Team.where(uid: session[:team_uid]).first)
      true
    else
      redirect_to :root
      false
    end
  end


end
