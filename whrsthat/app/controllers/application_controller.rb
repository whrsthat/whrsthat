class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
<<<<<<< HEAD
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
=======
  protect_from_forgery with: :null_session

  helper_method :current_user

  def current_user
    @user ||= User.find_by_id(session[:user])
  end

>>>>>>> a88abfa31435b227aabfbf31a8f025e8fe5f62c4
end
