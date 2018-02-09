# frozen_string_literal: true

# Class extracted from name controller.
class TaxonomyController::Index::ClientRequest::RunSearch::ListQuery
  def initialize(client_request)
    @client_request = client_request
  end

  def query_string
    TaxonomyController::Index::ClientRequest::Utilities::CoreArgsFilter.new(@client_request, raw_query_string).raw_query_string
                                                                       .sub(/"limit_placeholder"/, @client_request.limit.to_s)
                                                                       .sub(/"offset_placeholder"/, @client_request.offset.to_s)
  end

  def raw_query_string
    <<~HEREDOC
      {
        taxonomy_search(#{TaxonomyController::Index::ClientRequest::Utilities::CoreArgs.new.core_args},
                    limit: "limit_placeholder",
                    offset: "offset_placeholder")
          {
            count,
            taxa
            {
              id,
              record_type,
              simple_name,
              full_name,
              name_status_name,
              accepted_full_name,
              reference_citation
            }
          }
      }
    HEREDOC
  end
end
