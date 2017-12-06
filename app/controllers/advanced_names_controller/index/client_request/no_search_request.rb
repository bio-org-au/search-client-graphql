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

  def just_count?
    false
  end

  def content_partial
    nil
  end

  def details?
    false
  end

  def links?
    false
  end

  def family?
    false
  end

  def limit
    DEFAULT_LIMIT
  end
end
