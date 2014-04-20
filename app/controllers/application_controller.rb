class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # permitted parameters for Devise
  def configure_permitted_parameters
    additional_params = [:name, :bio]
    devise_parameter_sanitizer.for(:sign_up) << additional_params
    devise_parameter_sanitizer.for(:account_update) << additional_params
  end

end
