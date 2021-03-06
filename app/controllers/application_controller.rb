class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?

  def welcome
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  def redirect_because_logged_in
    if logged_in?
      flash[:logged_in] = 'Already logged in.'
      redirect_to user_path(current_user)
    end
  end

  def current_user=(user)
    session[:user_id] = user.id
    @current_user = user
  end

  private

  def require_login
    if logged_in?
      return
    else
      flash[:require_login] = 'Please Log In.'
      redirect_to root_path
    end
  end

  def auth_hash
    @auth_hash ||= request.env["omniauth.auth"]
  end

end
