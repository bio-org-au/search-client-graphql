# frozen_string_literal: true

# Constructs a Graphql name query request based on the client request query.
# Uses variables, so needs to declare the variables.
class NamesController::Index::GraphqlQuery
  QUERY_TYPE = 'filteredNames'

  def initialize(client_request)
    debug('initialize')
    @arg_types = NamesController::Index::Utilities::Argument.new.types
    @client_request = client_request
    @params = client_request.params
  end

  def args_from_params
    filter = +''
    @params.each_key do |key|
      #filter << "#{key}: $#{key},"
      filter << "#{key.to_s.camelize(:lower).to_sym}: $#{key},"
    end
    filter.chop!
    args = +''
    args << "filter: {#{filter}} "
    unless @client_request.just_count?
      args << ", count: #{@client_request.per_page},"
      args << "page: #{@client_request.page}"
    end
    debug("args: #{args}")
    args
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
    #decs << '$limit: Int, '
    #decs << '$offset: Int'
    decs
  end

  def query_header
    "query searchTag(#{var_declarations_from_params}) "
  end

  def variables_from_params
    vars = @params
    vars['count'] = @client_request.per_page
    vars['offset'] = @client_request.offset
    debug("variables_from_params vars: #{vars.to_json.to_s}")
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
