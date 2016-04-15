# Superclass for controllers.
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_default_show_results_as,
                :set_default_details_limit,
                :set_zone

  private

  def set_default_show_results_as
    if params.key?("show_results_as")
      session[:default_show_results_as] =
        valid_show_results_as(params[:show_results_as])
    else
      session[:default_show_results_as] ||= :list
    end
  end

  def set_default_details_limit
    if params.key?("details_limit")
      session[:default_details_limit] = params[:details_limit].to_i
    end
    return if session[:default_details_limit].to_i > 0
    session[:default_details_limit] = 20
  end

  private

  def set_zone
    @zone = ""
  end
  def valid_show_results_as(user_preference = "blank")
    case user_preference.downcase.strip
    when /\Alist\z/
      :list
    when /\Adetails\z/
      :details
    else
      :list
    end
  end
end
