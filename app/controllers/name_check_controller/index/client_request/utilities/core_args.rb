# frozen_string_literal: true

# Class extracted from name controller.
class NameCheckController::Index::ClientRequest::Utilities::CoreArgs
  def core_args
    <<~HEREDOC1
      names: "names_placeholder",
      limit: "limit_placeholder"
    HEREDOC1
  end
end
