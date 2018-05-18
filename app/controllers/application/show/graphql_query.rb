# frozen_string_literal: true

# Class extracted from name controller.
class Application::Show::GraphqlQuery
  def initialize(client_request)
    throw 'class Application::Show::GraphqlQuery'
    @client_request = client_request
  end

  def xas_string
    raw_query_string.delete(' ')
                    .delete("\n")
                    .sub(/id_placeholder/, @client_request.id)
  end

  private

  def xraw_query_string
    <<~HEREDOC
      {
        name(id: id_placeholder)
        {
            id,
            simple_name,
            full_name,
            full_name_html,
            family_name,
            name_status_name,
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
                  full_name,
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
    HEREDOC
  end
end
