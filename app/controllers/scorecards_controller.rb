class ScorecardsController < ApplicationController

  def show
    @registration = Registration.find params[:id]
    @person = @registration.person
    @sy = @registration.sessionyear
    @truthbooksignatures = @person.truthbooksignatures.limit(50)
    @scores = @person.scores_in(@sy)
  end

  def update
  end

end
