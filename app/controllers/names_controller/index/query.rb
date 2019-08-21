# frozen_string_literal: true

# Constructs a Graphql name query request based on the client request query.
# Uses variables, so needs to declare the variables.
class NamesController::Index::Query
  QUERY_TYPE = 'name_search'

  def initialize(client_request)
    debug('initialize')
    @arg_types = NamesController::Index::Utilities::Argument.new.types
    @client_request = client_request
    @params = client_request.params
  end

  def args_from_params
    args = +''
    @params.each_key do |key|
      args << "#{key}: $#{key},"
    end
    args << 'limit: $limit, '
    args << 'offset: $offset'
  end

  def query_string
    "{ #{QUERY_TYPE}(#{args_from_params}) #{query_data_structure} }"
  end

  def query_data_structure
    if @client_request.just_count?
      NamesController::Index::Utilities::Count.new.data_structure
    elsif @client_request.details?
      NamesController::Index::Utilities::Detail.new(@client_request).data_structure
    else
      NamesController::Index::Utilities::List.new.data_structure
    end
  end

  def var_declarations_from_params
    decs = +''
    @params.keys.each do |key|
      decs << "$#{key}:#{@arg_types[key]}, "
    end
    decs << '$limit: Int, '
    decs << '$offset: Int'
    decs
  end

  def query_header
    "query searchTag(#{var_declarations_from_params}) "
  end

  def variables_from_params
    vars = @params
    vars['limit'] = @client_request.limit
    vars['offset'] = @client_request.offset
    vars.to_json.to_s
  end

  def query_body
    { query: query_header + query_string, variables: variables_from_params }
  end

  private

  def debug(msg)
    Rails.logger.debug('==============================================')
    Rails.logger.debug("NamesController::Index:Query: #{msg}")
    Rails.logger.debug('==============================================')
  end
end
