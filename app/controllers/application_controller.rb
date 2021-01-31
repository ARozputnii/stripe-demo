class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true

  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    root_path
  end
end
