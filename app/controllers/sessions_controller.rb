class SessionsController < ApplicationController

  # before_action -> { authorize } # <= Don't, else can't login/out

  def create
    user = User.find_by_email(params[:email])
    if user && user.has_priv?(:login) && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "Logged in!"
    else
      msg = "Login Failure: Either email/pw is invalid, or you haven't been granted access"
      redirect_to login_url, alert: msg
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end

end
