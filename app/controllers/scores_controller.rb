class ScoresController < ApplicationController

  before_action :authorize

  def scoresheet
    @registration = Registration.find params[:id]
    @person = @registration.person
    @sy = @registration.sessionyear
    scores = Vwscore.scores_for(@person, @sy).ordered
    @scoresheet = Scoresheet.new(scores)

    @next_avail_bba_scores = Scoresheet.avail_bk_bib_att_scores
    @next_avail_section_scores = Scoresheet.avail_section_scores(@person)
    @next_avail_other_scores = Scoresheet.avail_other_scores
    render :scoresheet
  end

  def quick_add
    if params.has_key?("scoretypes")
      quick_add_nonsection_scores
    elsif params.has_key?("truthbooksections")
      quick_add_section_scores
    else
      raise "Error, unknown quick_add: #{params.inspect}"
    end
    redirect_to "/scoresheet/#{params[:registration_id]}"
  end

  private

  def quick_add_nonsection_scores
    p = params
    reg = Registration.find p[:registration_id]
    sd = reg.sessionyear.club_night_on(Date.today) # in case today is a sd
    rez_mgr = Scoresheet.add_nonsection_scores(reg.person, p[:scoretypes], sd, @current_user.person)
    if !rez_mgr.errors?
      flash[:success] = "Scores added!"
    else
      flash[:error] = "Failed! ...#{rez_mgr.errors.inspect}"
    end
  end

  def quick_add_section_scores
    p = params
    reg = Registration.find p[:registration_id]
    sd = reg.sessionyear.club_night_on(Date.today) # in case today is a sd

    rez_mgr = Scoresheet.add_section_scores(reg.person, p[:truthbooksections], sd, @current_user.person)
    if !rez_mgr.errors?
      flash[:success] = "Scores added!"
    else
      flash[:error] = "Failed! ...#{rez_mgr.errors.inspect}"
    end
  end

end
