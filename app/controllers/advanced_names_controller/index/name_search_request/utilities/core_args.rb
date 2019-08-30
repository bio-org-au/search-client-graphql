# frozen_string_literal: true

# Class extracted from name controller.
class AdvancedNamesController::Index::NameSearchRequest::Utilities::CoreArgs
  def core_args
    <<~HEREDOC1
      search_term: "search_term_placeholder",
      author_abbrev: "the_author_abbrev_placeholder",
      ex_author_abbrev: "ex_author_abbrev_placeholder",
      ex_base_author_abbrev: "ex_base_author_abbrev_placeholder",
      base_author_abbrev: "the_base_author_abbrev_placeholder",
      family: "family_placeholder",
      genus: "genus_placeholder",
      species: "species_placeholder",
      rank: "rank_placeholder",
      include_ranks_below: "include_ranks_below_placeholder",
      publication: "publication_placeholder",
      iso_publication_date: "iso_publication_date_placeholder",
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
      order_by_name: "order_by_name_placeholder"
    HEREDOC1
  end
end
