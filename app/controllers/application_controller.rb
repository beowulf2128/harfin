class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :before_filters

  private

  def before_filters
    # nothing yet
  end

  # Use this method as a before filter to put actions behind a login, and
  # access control actions per privileges.
  def authorize(access_hash)
    # 1) Login authentication
    if session[:user_id].blank?
      redirect_to login_url, alert: "Please login"
      return false
    end

    # 2) Roles/privs authorization. Everything denied, until allowed.
    priv = get_priv_for_action(params[:action], access_hash)
    if priv.nil? || !current_user.has_priv?(priv)
      redirect_to root_url, alert: "You do not have access"
      return false
    end
  end

  def get_priv_for_action(action, access_hash)
    access_hash.each do |priv, actions|
      return priv if actions.include?(action.to_sym)
    end
    return nil
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      return User.new
    end
  end
  helper_method :current_user

end
