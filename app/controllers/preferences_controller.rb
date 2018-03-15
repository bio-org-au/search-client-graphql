# frozen_string_literal: true

# Controller
class PreferencesController < ApplicationController
  def update
    if preferences_params[:on_off] =~ /on/i
      session[:show_edit_links] = true
    else
      session[:show_edit_links] = false
    end
    respond_to do |format|
      format.html
      format.js {render js: "$('#link-to-turn-off-edit-links').hide(); $('#footer-show-edit-links-area').html('Links off next query.');"}
    end
  end

  private
  def preferences_params
    params.permit(:switch, :on_off)
  end
end
