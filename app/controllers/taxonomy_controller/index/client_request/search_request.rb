# frozen_string_literal: true

# Class extracted from name controller.
class TaxonomyController::Index::ClientRequest::SearchRequest
  def initialize(params)
    @params = params
  end

  def any_type_of_search?
    name_search? || publication_search?
  end

  def xname_search?
    @params['q'].present? ||
      @params['family'].present? ||
      @params['author_abbrev'].present? ||
      @params['ex_author_abbrev'].present? ||
      @params['base_author_abbrev'].present? ||
      @params['ex_base_author_abbrev'].present? ||
      @params['genus'].present? ||
      @params['species'].present? ||
      @params['rank'].present? ||
      @params['name_element'].present? ||
      @params['publication_year'].present? ||
      @params['type_note_text'].present?
  end

  def xpublication_search?
    !name_search? && @params['publication'].present?
  end

  def just_count?
    @params[:list_or_count] == 'count'
  end

  def details?
    @params[:show_details].present? && @params[:show_details] == '1'
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

  def name?
    @params[:show_name].present? && @params[:show_name] == '1'
  end

  def show_name
    @params[:show_name]
  end

  def accepted_name?
    @params[:accepted_name].present? && @params[:accepted_name] == '1'
  end

  def excluded_name?
    @params[:excluded_name].present? && @params[:excluded_name] == '1'
  end

  def synonym?
    @params[:synonym].present? && @params[:synonym] == '1'
  end
end
