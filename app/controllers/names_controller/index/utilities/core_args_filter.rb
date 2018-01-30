# frozen_string_literal: true

# Class extracted from name controller.
class NamesController::Index::Utilities::CoreArgsFilter
  attr_reader :raw_query_string
  def initialize(client_request, raw_query_string)
    @client_request = client_request
    @raw_query_string = raw_query_string
    filter_raw_query_string
  end

  def filter_raw_query_string
    @raw_query_string =
      @raw_query_string.delete(' ')
                       .delete("\n")
                       .sub(/search_term_placeholder/, @client_request.search_term || '')
  end
end
