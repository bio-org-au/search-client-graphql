class Plants::Names::Search::Defaults::ShowAsController < ApplicationController
  def update
    session[:default_show_results_as] = new_default(params[:show_results_as])
    render text: params[:show_results_as]
  end

  private

  def new_default(possible_user_input = session[:default_show_results_as])
    return session[:default_show_results_as] if possible_user_input.blank?
    case possible_user_input.strip
    when /\Alist\z/
      'list'
    when /\Adetails\z/
      'details'
    else
      session[:default_show_results_as]
    end
  end

end
