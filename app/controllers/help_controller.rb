# frozen_string_literal: true

# Controller
class HelpController < ApplicationController
  def toggle
    session[:help] ||= false
    session[:help] = !session[:help]
    render js: "changeHelpSwitch(#{session[:help]});"
  end
end
