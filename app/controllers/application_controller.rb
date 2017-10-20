class ApplicationController < ActionController::Base
  before_action :ensure_logged_in, except: [:show, :index]

  protect_from_forgery with: :exception

  private

  def current_user
    # session[:user_id] && User.find(session[:user_id])
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def ensure_logged_in
    unless current_user
      flash[:alert] = "Please log in"
      redirect_to new_session_path
    end
  end
end
