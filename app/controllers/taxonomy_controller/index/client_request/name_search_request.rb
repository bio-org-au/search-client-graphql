# frozen_string_literal: true

# Class extracted from name controller.
class TaxonomyController::Index::ClientRequest::NameSearchRequest
  MAX_LIST_LIMIT = Rails.configuration.default_list_size_limit
  MAX_DETAILS_LIMIT = Rails.configuration.default_details_size_limit
  def initialize(params, search_request)
    Rails.logger.debug(self.class.name)
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
    "taxon_#{details? ? 'detail' : 'list'}"
  end

  def just_count?
    @search_request.just_count?
  end

  def list_or_count
    @params['list_or_count']
  end

  def name?
    @search_request.name?
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

  def xfamily
    return '' if @params[:family].blank?
    return '' unless @params[:family].class == String
    @params[:family].strip
  end

  def xgenus
    return '' if @params[:genus].blank?
    return '' unless @params[:genus].class == String
    @params[:genus].strip
  end

  def xspecies
    return '' if @params[:species].blank?
    return '' unless @params[:species].class == String
    @params[:species].strip
  end

  def xrank
    return '' if @params[:rank].blank?
    return '' unless @params[:rank].class == String
    @params[:rank].strip
  end

  def xinclude_ranks_below
    return '' if @params[:include_ranks_below].blank?
    return '' unless @params[:include_ranks_below].class == String
    @params[:include_ranks_below] == '1' ? 'true' : ''
  end

  def xpublication
    return '' if @params[:publication].blank?
    return '' unless @params[:publication].class == String
    @params[:publication].strip
  end

  def xprotologue
    return '' if @params[:protologue].blank?
    @params[:protologue].strip
  end

  def xname_element
    return '' if @params[:name_element].blank?
    return '' unless @params[:name_element].class == String
    @params[:name_element].strip
  end

  def xtype_note_text
    return '' if @params[:type_note_text].blank?
    return '' unless @params[:type_note_text].class == String
    @params[:type_note_text].strip
  end

  def xtype_note_keys
    %(["#{type_note_key_lectotype?}","#{type_note_key_type?}","#{type_note_key_neotype?}"])
  end

  def xtype_note_key_type?
    @params[:type_note_key_type] == '1' ? 'type' : ''
  end

  def xtype_note_key_lectotype?
    @params[:type_note_key_lectotype] == '1' ? 'lectotype' : ''
  end

  def xtype_note_key_neotype?
    @params[:type_note_key_neotype] == '1' ? 'neotype' : ''
  end

  def scientific_name
    (@params[:scientific_name] == '1').to_s
  end

  def scientific_autonym_name
    (@params[:scientific_autonym_name] == '1').to_s
  end

  def scientific_named_hybrid_name
    (@params[:scientific_named_hybrid_name] == '1').to_s
  end

  def scientific_hybrid_formula_name
    (@params[:scientific_hybrid_formula_name] == '1').to_s
  end

  def cultivar_name
    (@params[:cultivar_name] == '1').to_s
  end

  def common_name
    (@params[:common_name] == '1').to_s
  end

  # We never want to limit of zero
  def limit
    return 0 if just_count?
    limit = 1
    limit = if list?
              @params[:limit_per_page_for_list].to_i
            else
              @params[:limit_per_page_for_details].to_i
            end
    limit = 1 if limit < 1
    [limit, MAX_LIST_LIMIT].min
  end

  def offset
    [@params[:offset].to_i, 0].max
  end

  def timeout
    TimeoutCalculator.new(self).timeout
  end

  def accepted_name?
    @params[:accepted_names].present? && @params[:accepted_names] == '1'
  end

  def excluded_name?
    @params[:excluded_names].present? && @params[:excluded_names] == '1'
  end

  def cross_reference?
    @params[:cross_references].present? && @params[:cross_references] == '1'
  end

  def show_distributions?
    @params[:show_distributions].present? && @params[:show_distributions] == '1'
  end

  def show_synonyms?
    @params[:show_synonyms].present? && @params[:show_synonyms] == '1'
  end
end
