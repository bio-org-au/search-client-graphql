# frozen_string_literal: true

# Class extracted from name controller.
class AdvancedNamesController::Index::NameSearchRequest::List
  def initialize(client_request)
    throw 'list'
    @client_request = client_request
  end

  def query_string
    AdvancedNamesController::Index::NameSearchRequest::Utilities::CoreArgsFilter.new(@client_request, raw_query_string).raw_query_string
                                                                                               .sub(/"limit_placeholder"/, @client_request.limit.to_s)
                                                                                               .sub(/"offset_placeholder"/, @client_request.offset.to_s)
  end

  def raw_query_string
    <<~HEREDOC
      {
        name_search(#{AdvancedNamesController::Index::NameSearchRequest::Utilities::CoreArgs.new.core_args},
                    limit: "limit_placeholder",
                    offset: "offset_placeholder")
          {
            count,
            names
            {
              id,
              full_name,
              name_status_name,
              name_status_is_displayed,
              family_name
            }
          }
      }
    HEREDOC
  end
end
