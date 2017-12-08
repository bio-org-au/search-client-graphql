# frozen_string_literal: true

# Class extracted from name controller.
# This is the client's request (interpreted).
class AdvancedNamesController::Index::ClientRequest
  def initialize(params)
    @params = params
    @search_request = SearchRequest.new(params)
  end

  def build_request
    if @search_request.any_type_of_search?
      NameSearchRequest.new(@params, @search_request)
    else
      NoSearchRequest.new(@params, @search_request)
    end
  end

  def name_search?
    @search_request.name_search?
  end

  def publication_search?
    @search_request.publication_search?
  end

  def xdetails?
    @search_request.details?
  end
end
