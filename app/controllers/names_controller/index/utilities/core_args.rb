# frozen_string_literal: true

# Class extracted from name controller.
class NamesController::Index::Utilities::CoreArgs
  def core_args
    <<~HEREDOC1 
                search_term: "search_term_placeholder",
                scientific_name: "scientific_name_placeholder",
                scientific_autonym_name: "scientific_autonym_name_placeholder",
                scientific_hybrid_name: "scientific_hybrid_name_placeholder",
                cultivar_name: "cultivar_name_placeholder",
                common_name: "common_name_placeholder",
                fuzzy_or_exact: "fuzzy"
    HEREDOC1
  end
end
