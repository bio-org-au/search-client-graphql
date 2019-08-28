# frozen_string_literal: true

# Class extracted from name controller.
class AdvancedNamesController::Index::ClientRequest::NoSearchRequest
  def initialize(params, search_request, session_editor)
    @params = params
    @search_request = search_request
    @session_editor = session_editor
  end

  def params
    par = {}
    par[:search_term] =  @params[:q]
    par
  end

  def search; end

  def any_type_of_search?
    false
  end

  def publication_search?
    false
  end

  def name_search?
    false
  end

  def content_partial
    nil
  end

  def name?
    @search_request.name?
  end

  def details?
    @search_request.details?  || @session_editor
  end

  def links?
    @search_request.links?  || @session_editor
  end

  def family?
    @search_request.family?  || @session_editor
  end

  def limit
    DEFAULT_LIMIT
  end

  def just_count?
    @search_request.just_count?
  end

  def order_by_name?
    false
  end
end
