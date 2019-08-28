# frozen_string_literal: true

# Class extracted from name controller.
# This is the client's request (interpreted).
class TaxonomyController::Index::ClientRequest
  DEFAULT_LIMIT = 50
  MAX_LIST_LIMIT = 500
  MAX_DETAILS_LIMIT = 100
  AUTO_TRAILING_WILDCARD = true

  def initialize(params)
    @params = params
  end

  def params
    par = {}
    par[:search_term] =  @params[:q]
    par[:accepted_name] = true if @params[:accepted_name] == '1'
    par[:excluded_name] = true if @params[:excluded_name] == '1'
    par[:cross_reference] = true if @params[:cross_reference] == '1'
    par
  end

  def any_type_of_search?
    search_term.present? && some_type_of_record_selected?
  end

  def some_type_of_record_selected?
    @params["accepted_names"] == '1' ||
    @params["excluded_names"] == '1' ||
    @params["cross_references"] == '1'
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

  def xsearch
    TaxonomyController::Index::ClientRequest::RunSearch.new(self).result
  end

  def search_term
    return nil unless @params[:q].present?
    if AUTO_TRAILING_WILDCARD
      add_trailing_wildcard(@params[:q].strip)
    else
      @params[:q].strip
    end
  end

  def add_trailing_wildcard(string)
    return string if string =~ /[*%]$/
    return string.chop if string =~ /!$/ # user doesn't want wildcard
    string.sub(/$/, '*')
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
    [@params[:page].to_i, 0].max
  end

  def just_count?
    @params[:list_or_count] == 'count'
  end

  def distribution?
    @params[:show_distribution].present? && @params[:show_distribution] == '1'
  end

  def comments?
    @params[:show_comments].present? && @params[:show_comments] == '1'
  end

  def list?
    @params[:list_or_count] == 'list'
  end

  def family?
    @params[:show_family].present? && @params[:show_family] == '1'
  end

  def links?
    @params[:show_links].present? && @params[:show_links] == '1'
  end

  def details?
    false
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

  def synonyms?
    @params[:show_synonyms].present? && @params[:show_synonyms] == '1'
  end

  def no_search_message
    return [] if any_type_of_search?
    return [] if some_type_of_record_selected?
    return [] if @params.size < 3
    ["No search", %(Please choose at least one of "Accepted Names", "Excluded Names", or "Cross References")]
  end
end
