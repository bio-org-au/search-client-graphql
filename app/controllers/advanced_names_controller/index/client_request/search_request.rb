# frozen_string_literal: true

# Class extracted from name controller.
class AdvancedNamesController::Index::ClientRequest::SearchRequest
  def initialize(params)
    @params = params
  end

  def any_type_of_search?
    name_search? || publication_search?
  end

  def name_search?
    @params['q'].present? ||
      @params['family'].present? ||
      @params['taxon_name_author_abbrev'].present? ||
      @params['basionym_author_abbrev'].present? ||
      @params['genus'].present? ||
      @params['species'].present? ||
      @params['rank'].present? ||
      @params['name_element'].present? ||
      @params['publication_year'].present? ||
      @params['type_note_text'].present?
  end

  def publication_search?
    !name_search? && @params['publication'].present?
  end

  def just_count?
    @params[:count].present? && @params[:count].match(/count/i)
  end

  def details?
    @params[:show_details].present? && @params[:show_details] == 'show'
  end

  def list?
    !details?
  end

  def family?
    @params[:show_family].present? && @params[:show_family] == 'show'
  end

  def links?
    @params[:show_links].present? && @params[:show_links] == 'show'
  end
end
