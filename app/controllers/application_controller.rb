class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_action :current_user

  helper_method :current_user, :authenticated?

  def current_user
    return unless session[:user_id]
    @current_user = User.find_by_id(session[:user_id])
  end

  def authenticated?
    !current_user.nil?
  end
end
