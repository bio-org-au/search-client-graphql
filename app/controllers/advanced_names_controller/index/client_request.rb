# frozen_string_literal: true

# Class extracted from name controller.
class AdvancedNamesController::Index::ClientRequest
  def initialize(params)
    @params = params
  end

  def search?
    @params['q'].present? ||
      @params['family'].present? ||
      @params['author_abbrev'].present?
  end

  def search_term
    return '' if @params[:q].blank?
    return '' unless @params[:q].class == String
    @params[:q].strip
  end

  def author_abbrev
    return '' if @params[:author_abbrev].blank?
    return '' unless @params[:author_abbrev].class == String
    @params[:author_abbrev].strip
  end

  def family
    return '' if @params[:family].blank?
    return '' unless @params[:family].class == String
    @params[:family].strip
  end

  def name_type
    @params[:name_type]
  end

  def limit
    @params[:limit] || DEFAULT_LIMIT
  end

  def details?
    Rails.logger.debug('(advanced) details?')
    @params[:show_details].present? && @params[:show_details] == 'show'
  end
  alias show_details details?

  def list?
    !details?
  end

  def family?
    @params[:show_family].present? && @params[:show_family] == 'show'
  end

  def links?
    @params[:show_links].present? && @params[:show_links] == 'show'
  end

  def timeout
    TimeoutCalculator.new(limit: limit.to_i, details: details?).timeout
  end
end
