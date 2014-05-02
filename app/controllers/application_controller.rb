class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user

  def current_user
    return nil if session[:token].nil?
    @current_user ||= User.find_by_session_token(session[:token])
  end

  def logged_in?
    !!current_user
  end

  def login!(user)
    session[:token] = user.reset_session_token!
  end

  def logout
    current_user.reset_session_token!
    session[:token] = nil
  end

  def require_signed_in
    redirect_to new_session_url unless logged_in?
  end
end
