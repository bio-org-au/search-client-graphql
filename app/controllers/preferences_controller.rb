# frozen_string_literal: true

# Controller for preferences, such as indicating you want to be
# treated as an editor.
class PreferencesController < ApplicationController
  def editor_switch
    if preferences_params[:value] =~ /on/i
      session[:editor] = true
    else
      session[:editor] = false
    end
    respond_to do |format|
      format.html {redirect_to controller: 'names', action: 'index'}
      format.js {render 'editor_switch'}
    end
  end

  private

  def preferences_params
    params.permit(:switch, :value)
  end
end
