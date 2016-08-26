class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :before_filters

  def before_filters
    if !session[:logged_in]
      redirect_to '/sessions/login'
      return false
    end
  end

end
