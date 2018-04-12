# frozen_string_literal: true

# Superclass for controllers.
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :start_timer, :settings, :ranks

  rescue_from StandardError do |exception|
    case exception
    when Net::ReadTimeout
      logger.error("Rescued StandardError: #{exception}")
      @error = "The query took too long to run.  Go back and try again...."
      #exception.backtrace.each { |b| logger.error(b) }
      logger.error("Query took too long!")
      render :timeout_error
    else
      logger.error("Rescued StandardError: #{exception}")
      @error = exception
      exception.backtrace.each { |b| logger.error(b) }
      render :error
    end
  end

  private

  def start_timer
    @start_time = Time.now
  end

  # Make name label and tree label available 
  # in views - in tests too.
  def settings
    @setting = Setting.new
    @name_label = @setting.name_label
    @tree_label = @setting.tree_label
    @body_class = decide_body_class
  end

  def decide_body_class
    case params[:controller]
    when  'names' then 'name'
    when  'advanced_names' then 'name'
    when  'name_check' then 'name_check'
    when  'taxonomy' then 'taxonomy'
    else 'name'
    end
  end

  def ranks
    @rank_options = Rank.new.options
  end

  def timeout
    84
  end
end
