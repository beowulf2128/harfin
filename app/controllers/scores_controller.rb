class ScoresController < ApplicationController

  def show
    @registration = Registration.find params[:id]
    @person = @registration.person
    @sy = @registration.sessionyear
    scores = Vwscore.scores_for(@person, @sy).ordered
    @scoresheet = Scoresheet.new(scores)

    @next_avail_bba_scores = Scoresheet.avail_bk_bib_att_scores
    @next_avail_section_scores = Scoresheet.avail_section_scores(@person)
    @next_avail_other_scores = Scoresheet.avail_other_scores
  end

  def update
  end

end
