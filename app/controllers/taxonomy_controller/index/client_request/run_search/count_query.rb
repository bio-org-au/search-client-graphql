# frozen_string_literal: true

# Class extracted from name controller.
class TaxonomyController::Index::ClientRequest::RunSearch::CountQuery
  def initialize(client_request)
    @client_request = client_request
  end

  def query_string
    TaxonomyController::Index::ClientRequest::Utilities::CoreArgsFilter.new(@client_request, raw_query_string).raw_query_string
  end

  def raw_query_string
    <<~HEREDOC
      {
        taxonomy_search(#{TaxonomyController::Index::ClientRequest::Utilities::CoreArgs.new.core_args})
          {
            count
          }
      }
    HEREDOC
  end
end
