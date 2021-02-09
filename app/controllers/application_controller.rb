class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true

  before_action :authenticate_user!
  # before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_sign_in_path_for(resource)
    root_path
  end
end
