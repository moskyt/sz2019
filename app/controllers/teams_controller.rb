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

  def before_register
    @team = Team.where(uid: params[:uid]).first
    @data = @team.replies_register_
  end

  def before_register_submit
    flash[:notice] = "Přihláška uložena."
    @team = Team.where(uid: params[:uid]).first
    @team.update_attribute :replies_register, params[:register].to_json
    redirect_to module_before_team_path(uid: @team.uid)
  end

  def before_rules_go
    @team = Team.where(uid: params[:uid]).first
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
    @team = Team.where(uid: params[:uid]).first
    @team.update_attribute :ts_rules_done, Time.now.to_datetime
  end

  def before_rules_expired
    @team = Team.where(uid: params[:uid]).first
    @team.update_attribute :ts_rules_done, Time.now.to_datetime
    # save or ...
  end

  def before_rules_questions
    @team = Team.where(uid: params[:uid]).first
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
    @team = Team.where(uid: params[:uid]).first
  end

  def before_about_failed
    @team = Team.where(uid: params[:uid]).first
  end

  def before_about_upload
    @team = Team.where(uid: params[:uid]).first
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

end
