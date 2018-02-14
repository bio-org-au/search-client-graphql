# frozen_string_literal: true

# Class extracted from name controller.
# This is the client's request (interpreted).
class TaxonomyController::Index::ClientRequest
  DEFAULT_LIMIT = 50
  MAX_LIST_LIMIT = 500
  MAX_DETAILS_LIMIT = 100
  def initialize(params)
    @params = params
  end

  def any_type_of_search?
    search_term.present?
  end

  def search
    TaxonomyController::Index::ClientRequest::RunSearch.new(self).result
  end

  def search_term
    @params[:q].present? && @params[:q].gsub(/ *$/, '')
  end

  def scientific_name
    scientific?.to_s
  end

  def scientific_named_hybrid_name
    if @params[:scientific_named_hybrid_name] == '1'
      'true'
    else
      'false'
    end
  end

  def scientific_autonym_name
    scientific?.to_s
  end

  def scientific?
    %w[scientific all scientific-or-cultivar].include?(@params[:name_type]).to_s
  end

  def cultivar_name
    %w[cultivar all scientific-or-cultivar].include?(@params[:name_type]).to_s
  end

  def common_name
    %w[common all].include?(@params[:name_type]).to_s
  end

  # We don't want limit of zero unless it is a count request.
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

  def offset
    [@params[:offset].to_i, 0].max
  end

  def just_count?
    @params[:list_or_count] == 'count'
  end

  def details?
    @params[:show_details].present? && @params[:show_details] == '1'
  end
  alias show_details details?

  def distribution?
    @params[:show_distribution].present? && @params[:show_distribution] == '1'
  end

  def comments?
    @params[:show_comments].present? && @params[:show_comments] == '1'
  end

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

  def content_partial
    "taxon_#{details? ? 'detail' : 'list'}"
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

  def synonyms?
    @params[:show_synonyms].present? && @params[:show_synonyms] == '1'
  end
end
