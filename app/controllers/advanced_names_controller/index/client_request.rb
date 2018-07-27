# frozen_string_literal: true

# Class extracted from name controller.
# This is the client's request (interpreted).
class AdvancedNamesController::Index::ClientRequest
  def initialize(params, session_editor = false)
    @params = params
    @session_editor = session_editor
    @search_request = SearchRequest.new(params)
  end

  def build_request
    if @search_request.any_type_of_search?
      NameSearchRequest.new(@params, @search_request)
    else
      NoSearchRequest.new(@params, @search_request, @session_editor)
    end
  end

  def name_search?
    @search_request.name_search?
  end

  def publication_search?
    @search_request.publication_search?
  end
end
