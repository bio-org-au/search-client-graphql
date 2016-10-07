# frozen_string_literal: true

# Controller
class CitationsController < ApplicationController
  def toggle
    session[:citations] ||= false
    session[:citations] = !session[:citations]
    render js: "changeCitationsSwitch(#{session[:citations]});"
  end
end
