# frozen_string_literal: true

# Class extracted from name controller.
class AdvancedNamesController::Index::ClientRequest::NoSearchRequest
  def initialize(params, search_request)
    @params = params
    @search_request = search_request
  end

  def search
  end

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
    @search_request.details?
  end

  def links?
    @search_request.links?
  end

  def family?
    @search_request.family?
  end

  def limit
    DEFAULT_LIMIT
  end

  def just_count?
    @search_request.just_count?
  end
end
