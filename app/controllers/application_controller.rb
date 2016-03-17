# Superclass for controllers.
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_viewing_option

  def set_viewing_option
    session[:default_viewing_option] ||= :list
  end
end
