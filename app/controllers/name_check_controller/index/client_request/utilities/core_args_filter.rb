# frozen_string_literal: true

# Class extracted from name controller.
class NameCheckController::Index::ClientRequest::Utilities::CoreArgsFilter
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
      .sub(/"names_placeholder"/, @client_request.names_as_array_of_strings)
  end
end
