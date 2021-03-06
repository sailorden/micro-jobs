class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :signed_in?, :current_user, :same_user?, :owner?

  protected

  def signed_in?
    !current_user.nil?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def set_current_user(user)
    @current_user = user
  end

  def owner?(user)
    user == current_user
  end

  def authenticate!
    unless signed_in?
      flash[:notice] = 'You need to sign in if you want to do that!'
      redirect_to root_path
    end
  end

  def admin_authorize!
    if current_user.nil? or !current_user.is_admin?
      flash[:notice] = "You are not authorized to view this resource."
      redirect_to root_path
    end
  end
end
