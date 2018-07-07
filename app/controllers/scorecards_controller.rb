class ScorecardsController < ApplicationController

  # List relevant scoresheets
  def index
    #
  end

  def show
    @registration = Registration.find params[:id]
    @person = @registration.person
    @sy = @registration.sessionyear
  end

  def update
  end

end
