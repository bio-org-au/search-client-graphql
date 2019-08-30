# frozen_string_literal: true

# Class extracted from name controller.
class AdvancedNamesController::Index::ClientRequest::NameSearchRequest
  DEFAULT_LIMIT = 50
  MAX_LIST_LIMIT = Rails.configuration.default_list_size_limit
  MAX_DETAILS_LIMIT = Rails.configuration.default_details_size_limit
  def initialize(params, search_request)
    @params = params
    @search_request = search_request
  end

  def params
    par = {}
    par[:searchTerm] =  @params[:q]
    par[:family] = @params[:family].strip if include_string_param?(:family)
    par[:genus] = @params[:genus].strip if include_genus?
    par[:ex_base_author_abbrev] = @params[:ex_base_author_abbrev].strip if include_string_param?(:ex_base_author_abbrev)
    par[:base_author_abbrev] = @params[:base_author_abbrev].strip if include_string_param?(:base_author_abbrev)
    par[:ex_author_abbrev] = @params[:ex_author_abbrev].strip if include_string_param?(:ex_author_abbrev)
    par[:author_abbrev] = @params[:author_abbrev].strip if include_string_param?(:author_abbrev)
    par[:rank] = @params[:rank].strip if include_string_param?(:rank)
    par[:include_ranks_below] = true if include_boolean_param?(:include_ranks_below)

    par[:type_note_text] = @params[:type_note_text].strip if include_string_param?(:type_note_text)
    par[:type_note_keys] = type_note_keys if include_string_param?(:type_note_text)
    par[:species] = @params[:species].strip if include_string_param?(:species)

    par[:cultivar_name] = true if include_cultivar_names?
    par[:common_name] = true if include_common_names?
    par[:scientific_name] = true if include_scientific_names?
    par[:scientific_autonym_name] = true if include_scientific_autonym_names?
    par[:scientific_named_hybrid_name] = true if include_scientific_named_hybrid_names?
    par[:scientific_hybrid_formula_name] = true if include_scientific_hybrid_formula_names?

    par[:publication] = @params[:publication].strip if include_string_param?(:publication)
    par[:iso_publication_date] = @params[:iso_publication_date].strip if include_string_param?(:iso_publication_date)
    par[:protologue] = true if include_boolean_param?(:protologue)

    par
  end

  def include_cultivar_names?
    @params[:cultivar_name] == '1'
  end

  def include_common_names?
    @params[:common_name] == '1'
  end

  def per_page
    return 0 if just_count?
    per_page = if list?
                 @params[:limit_per_page_for_list].to_i
               else
                 @params[:limit_per_page_for_details].to_i
               end
    per_page = 1 if per_page < 1
    [per_page, MAX_LIST_LIMIT].min
  end

  def page
    [@params[:page].to_i || 1, 1].max
  end

  def include_scientific_names?
    @params[:scientific_name] == '1'
  end

  def include_scientific_autonym_names?
    @params[:scientific_autonym_name] == '1'
  end

  def include_scientific_named_hybrid_names?
    @params[:scientific_named_hybrid_name] == '1'
  end

  def include_scientific_hybrid_formula_names?
    @params[:scientific_hybrid_formula_name] == '1'
  end

  def include_boolean_param?(key)
    debug 'include boolean param'
    debug("key: #{key}")
    @params[key] == '1'
  end

  def type_of_search?
    'name_search'
  end

  def search
    throw 'old search'
    AdvancedNamesController::Index::NameSearchRequest::RunSearch.new(self).result
  end

  def name_search?
    true
  end

  def any_type_of_search?
    @search_request.any_type_of_search?
  end

  def content_partial
    "name_#{details? ? 'detail' : 'list'}"
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

  def include_string_param?(param_key)
    !@params[param_key].blank?
  end

  def include_genus?
    !@params[:genus].blank?
  end

  def include_ranks_below
    return false if @params[:include_ranks_below].blank?
    return false unless @params[:include_ranks_below].class == String
    (@params[:include_ranks_below] == '1').to_s
  end

  def publication
    return '' if @params[:publication].blank?
    return '' unless @params[:publication].class == String
    @params[:publication].strip
  end

  def iso_publication_date
    return '' if @params[:iso_publication_date].blank?
    return '' unless @params[:iso_publication_date].class == String
    @params[:iso_publication_date].strip
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
    keys = []
    keys.push 'type' if type_note_key_type?
    keys.push 'lectotype' if type_note_key_lectotype?
    keys.push 'neotype' if type_note_key_neotype?
    keys
  end

  def type_note_key_type?
    @params[:type_note_key_type] == '1'
  end

  def type_note_key_lectotype?
    @params[:type_note_key_lectotype] == '1'
  end

  def type_note_key_neotype?
    @params[:type_note_key_neotype] == '1'
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

  # We never want zero limit
  def limit
    return 0 if just_count?
    limit = if list?
              @params[:limit_per_page_for_list].to_i
            else
              @params[:limit_per_page_for_details].to_i
            end
    limit = 1 if limit < 1
    [limit, MAX_LIST_LIMIT].min
  end

  def xoffset
    [@params[:offset].to_i, 0].max
  end

  def timeout
    TimeoutCalculator.new(self).timeout
  end

  def accepted_name?
    @search_request.accepted_name?
  end

  def excluded_name?
    @search_request.excluded_name?
  end

  def synonym?
    @search_request.synonym?
  end

  def order_by_name?
    !family?
  end

  private

  def debug(msg)
    Rails.logger.debug("AdvancedNamesController::Index::ClientRequest::NameSearchRequest: #{msg}")
  end
end
