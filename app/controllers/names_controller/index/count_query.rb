# frozen_string_literal: true

# Class extracted from name controller.
class NamesController::Index::CountQuery
  def initialize(client_request)
    @client_request = client_request
  end

  def query_string
    NamesController::Index::Utilities::CoreArgsFilter.new(@client_request, raw_query_string).raw_query_string
  end

  def raw_query_string
    <<~HEREDOC
      {
        name_search(#{NamesController::Index::Utilities::CoreArgs.new.core_args})
          {
            count
          }
      }
    HEREDOC
  end
end

