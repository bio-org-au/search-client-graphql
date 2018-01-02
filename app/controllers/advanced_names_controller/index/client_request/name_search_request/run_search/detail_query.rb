# frozen_string_literal: true

# Class extracted from name controller.
class AdvancedNamesController::Index::ClientRequest::NameSearchRequest::RunSearch::DetailQuery
  def initialize(client_request)
    @client_request = client_request
  end

  def query_string
    raw_query_string.delete(' ')
                    .delete("\n")
                    .sub(/search_term_placeholder/, @client_request.search_term)
                    .sub(/taxon_name_author_abbrev_placeholder/, @client_request.taxon_name_author_abbrev)
                    .sub(/basionym_author_abbrev_placeholder/, @client_request.basionym_author_abbrev)
                    .sub(/family_placeholder/, @client_request.family)
                    .sub(/genus_placeholder/, @client_request.genus)
                    .sub(/species_placeholder/, @client_request.species)
                    .sub(/rank_placeholder/, @client_request.rank)
                    .sub(/publication_placeholder/, @client_request.publication)
                    .sub(/protologue_placeholder/, @client_request.protologue)
                    .sub(/name_element_placeholder/, @client_request.name_element)
                    .sub(/type_of_name_placeholder/, @client_request.name_type)
                    .sub(/type_note_text_placeholder/, @client_request.type_note_text || '')
                    .sub(/"type_note_keys_placeholder"/, @client_request.type_note_keys || '')
                    .sub(/"limit_placeholder"/, @client_request.limit.to_s)
                    .sub(/"offset_placeholder"/, @client_request.offset.to_s)
  end

  private

  def raw_query_string
    <<~HEREDOC
      {
        name_search(search_term: "search_term_placeholder",
                    taxon_name_author_abbrev: "taxon_name_author_abbrev_placeholder",
                    basionym_author_abbrev: "basionym_author_abbrev_placeholder",
                    family: "family_placeholder",
                    genus: "genus_placeholder",
                    species: "species_placeholder",
                    rank: "rank_placeholder",
                    publication: "publication_placeholder",
                    protologue: "protologue_placeholder",
                    name_element: "name_element_placeholder",
                    type_of_name: "type_of_name_placeholder",
                    fuzzy_or_exact: "fuzzy",
                    type_note_text: "type_note_text_placeholder",
                    type_note_keys: "type_note_keys_placeholder",
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
