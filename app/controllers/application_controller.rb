class ApplicationController < ActionController::Base
  include PublicActivity::StoreController

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit :username, :email, :password, :password_confirmation, :remember_me
    end
  end
end
