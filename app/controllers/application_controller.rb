class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def logged_in?
    !!current_user
  end

  def current_user
    # returns the name of the current user
    # returns nil if nobody is logged in
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    redirect_to root_url unless current_user
  end
end
