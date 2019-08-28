# frozen_string_literal: true

# Class extracted from name controller.
class AdvancedNamesController::Index::ClientRequest::PublicationRequest::RunSearch::CountQuery
  def initialize(client_request)
    throw 'count query'
    @client_request = client_request
  end

  def query_string
    raw_query_string.delete(' ')
                    .delete("\n")
                    .sub(/publication_placeholder/, @client_request.publication)
                    .sub(/"limit_placeholder"/, @client_request.limit)
  end

  def raw_query_string
    <<~HEREDOC
      {
        publication_search(publication: "publication_placeholder",
                           limit: "limit_placeholder")
          {
            count
          }
      }
    HEREDOC
  end
end
