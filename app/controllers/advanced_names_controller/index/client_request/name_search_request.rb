# frozen_string_literal: true

# Class extracted from name controller.
class AdvancedNamesController::Index::ClientRequest::NameSearchRequest
  DEFAULT_LIMIT = 50
  MAX_LIST_LIMIT = 500
  MAX_DETAILS_LIMIT = 100
  def initialize(params, search_request)
    @params = params
    @search_request = search_request
  end

  def type_of_search?
    'name_search'
  end

  def search
    RunSearch.new(self).result
  end

  def name_search?
    true
  end

  def any_type_of_search?
    @search_request.any_type_of_search?
  end

  def content_partial
    "name_#{ details? ? 'detail' : 'list' }"
  end

  def just_count?
    @search_request.just_count?
  end

  def details?
    @search_request.details?
  end
  alias show_details details?

  def list?
    !details?
  end

  def family?
    @search_request.family?
  end

  def links?
    @search_request.links?
  end

  def search_term
    return '' if @params[:q].blank?
    return '' unless @params[:q].class == String
    @params[:q].strip
  end

  def taxon_name_author_abbrev
    return '' if @params[:taxon_name_author_abbrev].blank?
    return '' unless @params[:taxon_name_author_abbrev].class == String
    @params[:taxon_name_author_abbrev].strip
  end

  def basionym_author_abbrev
    return '' if @params[:basionym_author_abbrev].blank?
    return '' unless @params[:basionym_author_abbrev].class == String
    @params[:basionym_author_abbrev].strip
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

  def include_ranks_below
    return '' if @params[:include_ranks_below].blank?
    return '' unless @params[:include_ranks_below].class == String
    @params[:include_ranks_below] == '1' ? 'true' : ''
  end

  def publication
    return '' if @params[:publication].blank?
    return '' unless @params[:publication].class == String
    @params[:publication].strip
  end

  def protologue
    return '' if @params[:protologue].blank?
    @params[:protologue].strip
  end

  def name_element
    return '' if @params[:name_element].blank?
    return '' unless @params[:name_element].class == String
    @params[:name_element].strip
  end

  def type_note_text
    return '' if @params[:type_note_text].blank?
    return '' unless @params[:type_note_text].class == String
    @params[:type_note_text].strip
  end

  def type_note_keys
    %Q(["#{type_note_key_lectotype?}","#{ type_note_key_type? }","#{ type_note_key_neotype? }"])
  end

  def type_note_key_type?
    @params[:type_note_key_type] == '1' ? 'type' : ''
  end

  def type_note_key_lectotype?
    @params[:type_note_key_lectotype] == '1' ? 'lectotype' : ''
  end

  def type_note_key_neotype?
    @params[:type_note_key_neotype] == '1' ? 'neotype' : ''
  end

  def name_type
    @params[:name_type]
  end

  def limit
    if list?
      [@params[:limit].to_i, MAX_LIST_LIMIT].min
    else
      [@params[:limit].to_i, MAX_DETAILS_LIMIT].min
    end
  end

  def offset
    [@params[:offset].to_i,0].max
  end

  def timeout
    TimeoutCalculator.new(self).timeout
  end
end
