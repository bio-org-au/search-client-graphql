# frozen_string_literal: true
class AlwaysDetailsController < ApplicationController
  def toggle
    Rails.logger.debug("always details toggle")
    session[:always_details] ||= false
    session[:always_details] = !session[:always_details]
    render js: "changeAlwaysDetailsSwitch(#{session[:always_details]});"
  end
end
