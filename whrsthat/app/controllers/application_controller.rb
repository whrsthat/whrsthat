class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  #if special token missing will fail
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    @user ||= User.find_by_id(session[:user])
  end
end
