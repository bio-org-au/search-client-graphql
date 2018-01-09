# frozen_string_literal: true

# Class extracted from name controller.
class NamesController::Index::ClientRequest
  def initialize(params)
    @params = params
  end

  def any_type_of_search?
    search_term.present?
  end

  def search_term
    @params[:q].present? && @params[:q].gsub(/ *$/, '')
  end

  def scientific_name
    scientific?.to_s
  end

  def scientific_hybrid_name
    scientific?.to_s
  end

  def scientific_autonym_name
    scientific?.to_s
  end

  def scientific?
    %w(scientific all scientific-or-cultivar).include?(@params[:name_type]).to_s
  end

  def cultivar_name
    %w(cultivar all scientific-or-cultivar).include?(@params[:name_type]).to_s
  end

  def common_name
    %w(common all).include?(@params[:name_type]).to_s
  end

  def limit
    @params[:limit].to_i || DEFAULT_LIMIT
  end

  def offset
    0
  end

  def just_count?
    @params[:count].present? && @params[:count].match(/count/i)
  end

  def details?
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

  def content_partial
    "name_#{ details? ? 'detail' : 'list' }"
  end
end
