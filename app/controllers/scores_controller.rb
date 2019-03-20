class ScoresController < ApplicationController

  def show
    @registration = Registration.find params[:id]
    @person = @registration.person
    @sy = @registration.sessionyear
    @truthbooksignatures = @person.truthbooksignatures.limit(50)
    @scores = Vwscore.scores_for(@person, @sy).ordered
  end

  def update
  end

end
