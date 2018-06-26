# frozen_string_literal: true

# Class extracted from name controller.
class NamesController::Index::DetailQuery
  def initialize(client_request)
    debug('initialize')
    @client_request = client_request
  end

  def debug(s)
    Rails.logger.debug('==============================================')
    Rails.logger.debug("NamesController::Index:DetailQuery: #{s}")
    Rails.logger.debug('==============================================')
  end

  def query_string
    NamesController::Index::Utilities::CoreArgsFilter.new(@client_request, raw_query_string).raw_query_string
                                                     .sub(/"limit_placeholder"/, @client_request.limit.to_s)
                                                     .sub(/"offset_placeholder"/, @client_request.offset.to_s)
  end

  private

  def raw_query_string
    <<~HEREDOC
      {
        name_search(#{NamesController::Index::Utilities::CoreArgs.new.core_args},
                    limit: "limit_placeholder",
                    offset: "offset_placeholder")
        {
          count,
          names
           #{Application::Names::DetailQueryReusableParts.name_fields_string}
        }
      }
    HEREDOC
  end
end
