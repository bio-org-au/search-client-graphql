# frozen_string_literal: true

# Class extracted from publications controller.
class PublicationsController::Suggestions::ListQuery
  def initialize(client_request)
    @client_request = client_request
  end

  def query_string
    raw_query_string.delete(' ')
                    .delete("\n")
                    .sub(/search_term_placeholder/, @client_request.search_term)
  end

  def raw_query_string
    <<~HEREDOC
      {
        publication_search(publication: "search_term_placeholder")
          {
            publications
            {
              citation
            }
          }
      }
    HEREDOC
  end
end
