class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def send_home
    if current_user
      redirect_to home_path
    end
  end

  def require_user
    unless current_user
      redirect_to sign_in_path
    end
  end

  def require_admin
    unless current_user.admin?
      redirect_to root_path
      flash[:danger] = "Admin only!"
    end
  end
end
