# frozen_string_literal: true

# Class extracted from name controller.
class AdvancedNamesController::Index::ListQuery
  def initialize(client_request)
    Rails.logger.debug('list query')
    @client_request = client_request
  end

  def query_string
    raw_query_string.delete(' ')
                    .delete("\n")
                    .sub(/search_term_placeholder/, @client_request.search_term)
                    .sub(/author_abbrev_placeholder/,
                         @client_request.author_abbrev)
                    .sub(/family_placeholder/, @client_request.family)
                    .sub(/genus_placeholder/, @client_request.genus)
                    .sub(/rank_placeholder/, @client_request.rank)
                    .sub(/type_of_name_placeholder/, @client_request.name_type)
                    .sub(/"limit_placeholder"/, @client_request.limit)
  end

  def raw_query_string
    <<~HEREDOC
      {
        name_search(search_term: "search_term_placeholder",
                    author_abbrev: "author_abbrev_placeholder",
                    family: "family_placeholder",
                    genus: "genus_placeholder",
                    rank: "rank_placeholder",
                    type_of_name: "type_of_name_placeholder",
                    fuzzy_or_exact: "fuzzy",
                    limit: "limit_placeholder")
          {
            count,
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
