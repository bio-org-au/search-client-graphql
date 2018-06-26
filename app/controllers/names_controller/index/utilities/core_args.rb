# frozen_string_literal: true

# Class extracted from name controller.
class NamesController::Index::Utilities::CoreArgs
  def core_args
    <<~HEREDOC1
      search_term: "search_term_placeholder",
      order_by_name: "order_by_name_placeholder",
      order_by_name_within_family: "order_by_name_within_family_placeholder"
    HEREDOC1
  end
end
