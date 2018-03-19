# frozen_string_literal: true

# Class extracted from name controller.
class AdvancedNamesController::Index::ClientRequest::NameSearchRequest::Utilities::CoreArgsFilter
  attr_reader :raw_query_string
  def initialize(client_request, raw_query_string)
    @client_request = client_request
    @raw_query_string = raw_query_string
    filter_raw_query_string
  end

  def filter_raw_query_string
    @raw_query_string =
      @raw_query_string.delete(' ')
                       .delete("\n")
                       .sub(/search_term_placeholder/, @client_request.search_term || '')
                       .sub(/taxon_name_author_abbrev_placeholder/, @client_request.taxon_name_author_abbrev || '')
                       .sub(/basionym_author_abbrev_placeholder/, @client_request.basionym_author_abbrev || '')
                       .sub(/family_placeholder/, @client_request.family || '')
                       .sub(/genus_placeholder/, @client_request.genus || '')
                       .sub(/species_placeholder/, @client_request.species || '')
                       .sub(/rank_placeholder/, @client_request.rank || '')
                       .sub(/include_ranks_below_placeholder/, @client_request.include_ranks_below || '')
                       .sub(/publication_placeholder/, @client_request.publication || '')
                       .sub(/publication_year_placeholder/, @client_request.publication_year || '')
                       .sub(/protologue_placeholder/, @client_request.protologue || '')
                       .sub(/name_element_placeholder/, @client_request.name_element || '')
                       .sub(/"scientific_name_placeholder"/, @client_request.scientific_name || '')
                       .sub(/"scientific_autonym_name_placeholder"/, @client_request.scientific_autonym_name || '')
                       .sub(/"scientific_named_hybrid_name_placeholder"/, @client_request.scientific_named_hybrid_name || '')
                       .sub(/"scientific_hybrid_formula_name_placeholder"/, @client_request.scientific_hybrid_formula_name || '')
                       .sub(/"cultivar_name_placeholder"/, @client_request.cultivar_name || '')
                       .sub(/"common_name_placeholder"/, @client_request.common_name || '')
                       .sub(/type_note_text_placeholder/, @client_request.type_note_text || '')
                       .sub(/"type_note_keys_placeholder"/, @client_request.type_note_keys || '')
                       .sub(/"order_by_name_placeholder"/, @client_request.order_by_name?.to_s || '')
  end
end
