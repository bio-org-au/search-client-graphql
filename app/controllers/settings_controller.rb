# frozen_string_literal: true

# Controller
class SettingsController < ApplicationController
  def index
  end

  def background
    session[:background] = params[:background]
    head :ok
  end
end
