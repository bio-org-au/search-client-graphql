# frozen_string_literal: true

# Superclass for controllers.
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :start_timer, :settings
  # rescue_from 'Errno::ECONNREFUSED', with: :rescue_error
  rescue_from StandardError do |exception|
    logger.error("Rescued StandardError: #{exception}")
    @error = exception
    exception.backtrace.each { |b| logger.error(b) }
    render :error
  end

  private

  def start_timer
    @start_time = Time.now
  end

  def settings
    @setting = Setting.new
    @name_label = @setting.name_label
    @taxonomy_label = @setting.taxonomy_label
  end

  def timeout
    84
  end
end
