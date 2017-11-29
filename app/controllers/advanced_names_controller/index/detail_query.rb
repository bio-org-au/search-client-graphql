# frozen_string_literal: true

# Class extracted from name controller.
class AdvancedNamesController::Index::DetailQuery
  def initialize(client_request)
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
                    .sub(/species_placeholder/, @client_request.species)
                    .sub(/rank_placeholder/, @client_request.rank)
                    .sub(/publication_placeholder/, @client_request.publication)
                    .sub(/epithet_placeholder/, @client_request.epithet)
                    .sub(/type_of_name_placeholder/, @client_request.name_type)
                    .sub(/"limit_placeholder"/, @client_request.limit)
  end

  private

  def raw_query_string
    <<~HEREDOC
      {
        name_search(search_term: "search_term_placeholder",
                    author_abbrev: "author_abbrev_placeholder",
                    family: "family_placeholder",
                    genus: "genus_placeholder",
                    species: "species_placeholder",
                    rank: "rank_placeholder",
                    publication: "publication_placeholder",
                    epithet: "epithet_placeholder",
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
