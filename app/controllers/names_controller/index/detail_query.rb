# frozen_string_literal: true

# Class extracted from name controller.
class NamesController::Index::DetailQuery
  def initialize(form_request)
    @form_request = form_request
  end

  def query_string
    raw_query_string.delete(' ')
                    .delete("\n")
                    .sub(/search_term_placeholder/, @form_request.search_term)
                    .sub(/type_of_name_placeholder/, @form_request.name_type)
                    .sub(/"limit_placeholder"/, @form_request.limit)
  end

  private

  def raw_query_string
    <<~HEREDOC
      {
        name_search(search_term: "search_term_placeholder",
                    type_of_name: "type_of_name_placeholder",
                    fuzzy_or_exact: "fuzzy",
                    limit: "limit_placeholder")
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
                  has_type_synonym,
                  of_type_synonym,
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
