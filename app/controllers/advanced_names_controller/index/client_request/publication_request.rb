# frozen_string_literal: true

# Class extracted from name controller.
class AdvancedNamesController::Index::ClientRequest::PublicationRequest
  def initialize(params, search_request)
    @params = params
    @search_request = search_request
  end

  def search
    RunSearch.new(self).result
  end

  def any_type_of_search?
    publication_search
  end

  def publication_search?
    true
  end

  def name_search?
    false
  end

  def just_count?
    @params[:count].present? && @params[:count].match(/count/i)
  end

  def content_partial
    "publication_#{ details? ? 'detail' : 'list' }"
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

  def name_element
    return '' if @params[:name_element].blank?
    return '' unless @params[:name_element].class == String
    @params[:name_element].strip
  end

  def name_type
    @params[:name_type]
  end

  def limit
    @params[:limit] || DEFAULT_LIMIT
  end

  def details?
    @params[:show_details].present? && @params[:show_details] == '1'
  end
  alias show_details details?

  def list?
    !details?
  end

  def family?
    @params[:show_family].present? && @params[:show_family] == '1'
  end

  def links?
    @params[:show_links].present? && @params[:show_links] == '1'
  end

  def timeout
    TimeoutCalculator.new(self).timeout
  end
end
