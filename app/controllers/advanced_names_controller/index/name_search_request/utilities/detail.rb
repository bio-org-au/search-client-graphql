# frozen_string_literal: true

# Class extracted from name controller.
class AdvancedNamesController::Index::NameSearchRequest::Detail
  def initialize(client_request)
    throw 'detail'
    @client_request = client_request
  end

  def query_string
    AdvancedNamesController::Index::NameSearchRequest::Utilities::CoreArgsFilter.new(@client_request, raw_query_string).raw_query_string
                                                                                               .sub(/"limit_placeholder"/, @client_request.limit.to_s)
                                                                                               .sub(/"offset_placeholder"/, @client_request.offset.to_s)
  end

  private

  def raw_query_string
    <<~HEREDOC
      {
        name_search(#{AdvancedNamesController::Index::NameSearchRequest::Utilities::CoreArgs.new.core_args},
                    limit: "limit_placeholder",
                    offset: "offset_placeholder")
        {
          count,
          names
          #{Application::Names::DetailQueryReusableParts.new(@client_request).name_fields_string}
        }
      }
    HEREDOC
  end

  def xraw_query_string
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
            simple_name,
            full_name,
            full_name_html,
            name_status_name,
            family_name,
              name_usages
              {
                standalone,
                instance_id,
                instance_type_name,
                primary_instance,
                accepted_tree_status,
                reference_details {
                  id,
                  citation,
                  page,
                  page_qualifier,
                  year,
                }, 
                misapplication_details {
                  direction,
                  misapplied_to_full_name,
                  misapplied_to_name_id,
                  misapplied_in_reference_citation,
                  misapplied_in_reference_id,
                  misapplied_on_page,
                  misapplied_on_page_qualifier,
                  misapplication_type_label,
                }
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
    HEREDOC
  end
end
