# frozen_string_literal: true

# Class extracted from name controller.
class AdvancedNamesController::Index::ClientRequest::NameSearchRequest
  def initialize(params)
    @params = params
  end

  def type_of_search?
    'name_search'
  end

  def just_count?
    @params[:count].present? && @params[:count].match(/count/i)
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

  def genus
    return '' if @params[:genus].blank?
    return '' unless @params[:genus].class == String
    @params[:genus].strip
  end

  def species
    return '' if @params[:species].blank?
    return '' unless @params[:species].class == String
    @params[:species].strip
  end

  def rank
    return '' if @params[:rank].blank?
    return '' unless @params[:rank].class == String
    @params[:rank].strip
  end

  def publication
    return '' if @params[:publication].blank?
    return '' unless @params[:publication].class == String
    @params[:publication].strip
  end

  def epithet
    return '' if @params[:epithet].blank?
    return '' unless @params[:epithet].class == String
    @params[:epithet].strip
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
    TimeoutCalculator.new(self).timeout
  end
end
