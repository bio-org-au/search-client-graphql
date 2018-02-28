# frozen_string_literal: true

# Class extracted from name controller.
class TaxonomyController::Index::ClientRequest::Utilities::CoreArgs
  def core_args
    <<~HEREDOC1
      search_term: "search_term_placeholder",
      accepted_name: "accepted_name_placeholder",
      excluded_name: "excluded_name_placeholder",
      cross_reference: "cross_reference_placeholder"
    HEREDOC1
  end
end
