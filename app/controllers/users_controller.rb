class UsersController < ApplicationController

  ACCESS = {
    edit_persons: [:new, :create]
  }
  before_action -> { authorize(ACCESS) } # TODO need admin priv

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Thank you for signing up!"
    else
      render "new"
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.fetch(:user, {}).permit(:email, :password, :password_confirmation)
  end

end


