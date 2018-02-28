# frozen_string_literal: true

# Class extracted from name controller.
class TaxonomyController::Index::ClientRequest::Utilities::CoreArgsFilter
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
                       .sub(/"accepted_name_placeholder"/, @client_request.accepted_name?.to_s || 'false')
                       .sub(/"excluded_name_placeholder"/, @client_request.excluded_name?.to_s || 'false')
                       .sub(/"cross_reference_placeholder"/, @client_request.cross_reference?.to_s || 'false')
  end
end
