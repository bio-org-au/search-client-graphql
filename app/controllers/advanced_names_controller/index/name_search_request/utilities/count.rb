# frozen_string_literal: true

# Class extracted from name controller.
class AdvancedNamesController::Index::NameSearchRequest::Utilities::Count
  def initialize(client_request)
    throw 'count'
    @client_request = client_request
  end

  def query_string
    AdvancedNamesController::Index::NameSearchRequest::Utilities::CoreArgsFilter.new(@client_request, raw_query_string).raw_query_string
  end

  def raw_query_string
    <<~HEREDOC
      {
        name_search(#{AdvancedNamesController::Index::ClientRequest::NameSearchRequest::Utilities::CoreArgs.new.core_args})
          {
            count
          }
      }
    HEREDOC
  end
end
