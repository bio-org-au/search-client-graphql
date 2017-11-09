# frozen_string_literal: true

# Class extracted from name controller.
class NameController::ListQuery
  def initialize(form_request)
    @form_request = form_request
  end

  def query_string
    interpolated_query_string
  end

  def interpolated_query_string
    raw_query_string.delete(" ")
                    .delete("\n")
                    .sub(/search_term_placeholder/, @form_request.search_term)
                    .sub(/type_of_name_placeholder/, @form_request.name_type)
                    .sub(/"limit_placeholder"/, @form_request.limit)
  end

  def raw_query_string
    <<~HEREDOC
      {
        name_search(search_term: "search_term_placeholder",
                    type_of_name: "type_of_name_placeholder",
                    fuzzy_or_exact: "fuzzy",
                    limit: "limit_placeholder")
          {
            names
            {
              id,
              full_name,
              name_status_name,
              family_name
            }
          }
      }
    HEREDOC
  end
end
