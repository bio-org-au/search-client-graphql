# frozen_string_literal: true

# ClientRequest for PublicationsController
class PublicationsController::Suggestions::ClientRequest
  def initialize(params)
    @params = params
  end

  def any_type_of_search?
    search_term.present?
  end

  def search_term
    @params[:search_term].present? && @params[:search_term].gsub(/ *$/, '')
  end

  def limit
    50
  end

  def just_count?
    false
  end

  def details?
    false
  end

  def timeout
    TimeoutCalculator.new(self).timeout
  end
end
