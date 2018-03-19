# frozen_string_literal: true

# Class extracted from name controller.
class AdvancedNamesController::Index::ClientRequest::NameSearchRequest::Utilities::CoreArgs
  def core_args
    <<~HEREDOC1
      search_term: "search_term_placeholder",
      taxon_name_author_abbrev: "taxon_name_author_abbrev_placeholder",
      basionym_author_abbrev: "basionym_author_abbrev_placeholder",
      family: "family_placeholder",
      genus: "genus_placeholder",
      species: "species_placeholder",
      rank: "rank_placeholder",
      include_ranks_below: "include_ranks_below_placeholder",
      publication: "publication_placeholder",
      publication_year: "publication_year_placeholder",
      protologue: "protologue_placeholder",
      name_element: "name_element_placeholder",
      scientific_name: "scientific_name_placeholder",
      scientific_autonym_name: "scientific_autonym_name_placeholder",
      scientific_named_hybrid_name: "scientific_named_hybrid_name_placeholder",
      scientific_hybrid_formula_name: "scientific_hybrid_formula_name_placeholder",
      cultivar_name: "cultivar_name_placeholder",
      common_name: "common_name_placeholder",
      type_note_text: "type_note_text_placeholder",
      type_note_keys: "type_note_keys_placeholder",
      fuzzy_or_exact: "fuzzy",
      order_by_name: "order_by_name_placeholder"
    HEREDOC1
  end
end
