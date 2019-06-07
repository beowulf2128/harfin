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

  def new
    @registration = Registration.find(params[:registration_id])

    @score = Score.new do |s|
      s.clubber_id = params[:clubber_id]
      s.scoretype = Scoretype.section
      s.point_value = Scoretype.section.suggested_point_value
    end
  end

  def create
    @score = Score.new(score_params)
    @score.recorded_by = @current_user.person
    respond_to do |format|
      if @score.save
        format.html { redirect_to "/scoresheet/#{params[:score][:registration_id]}", notice: 'Score saved!' }
#         format.json { render :show, status: :created, location: @registration }
      else
        format.html { render :new }
#         format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
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

  private

    def score_params
      params.fetch(:score, {}).permit(:clubber_id, :sessionday_id, :scoretype_id,
                                        :point_value, :truthbooksignature_id)
    end

end
