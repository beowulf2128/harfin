class ScoresController < ApplicationController

  def show
    @registration = Registration.find params[:id]
    @person = @registration.person
    @sy = @registration.sessionyear
    scores = Vwscore.scores_for(@person, @sy).ordered
    @scoresheet = Scoresheet.new(scores)
  end

  def update
  end

end
