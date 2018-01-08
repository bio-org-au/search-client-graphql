# frozen_string_literal: true

# Class extracted from name controller.
class AdvancedNamesController::Index::ClientRequest::NameSearchRequest::RunSearch::DetailQuery
  def initialize(client_request)
    @client_request = client_request
  end

  def query_string
    AdvancedNamesController::Index::ClientRequest::NameSearchRequest::Utilities::CoreArgsFilter.new(@client_request, raw_query_string).raw_query_string
                    .sub(/"limit_placeholder"/, @client_request.limit.to_s)
                    .sub(/"offset_placeholder"/, @client_request.offset.to_s)
  end

  private

  def raw_query_string
    <<~HEREDOC
      {
        name_search(#{AdvancedNamesController::Index::ClientRequest::NameSearchRequest::Utilities::CoreArgs.new.core_args},
                    limit: "limit_placeholder",
                    offset: "offset_placeholder")
        {
          count,
          names
          {
            id,
            simple_name,
            full_name,
            full_name_html,
            name_status_name,
            family_name,
            name_history
            {
              name_usages
              {
                instance_id,
                reference_id,
                citation,
                page,
                page_qualifier,
                year,
                standalone,
                instance_type_name,
                primary_instance,
                misapplied,
                misapplied_to_name,
                misapplied_to_id,
                misapplied_by_id,
                misapplied_by_citation,
                misapplied_on_page,
                synonyms {
                  id,
                  name_id,
                  full_name,
                  full_name_html,
                  instance_type,
                  label,
                  page,
                  name_status_name,
                }
                notes {
                  id,
                  key,
                  value
                }
              }
            }
          }
        }
      }
    HEREDOC
  end
end
