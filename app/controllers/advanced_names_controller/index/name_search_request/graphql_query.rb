# frozen_string_literal: true

# Constructs a Graphql name query request based on the client request query.
# Uses variables, so needs to declare the variables.
class AdvancedNamesController::Index::NameSearchRequest::GraphqlQuery
  QUERY_TYPE = 'filteredNames'

  def initialize(client_request)
    debug('initialize')
    @arg_types = AdvancedNamesController::Index::NameSearchRequest::Utilities::Argument.new.types
    @client_request = client_request
    @params = client_request.params
  end

  def args_from_params
    filter = +''
    @params.each_key do |key|
      filter << "#{key.to_s.camelize(:lower).to_sym}: $#{key.to_s.camelize(:lower).to_sym},"
    end
    filter.chop!
    args = +''
    args << "filter: {#{filter}}"
    unless @client_request.just_count?
      args << ", count: $count,"
      args << "page: $page"
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
    debug('var_declarations_from_params')
    decs = +''
    @params.keys.each do |key|
      camel_key = key.to_s.camelize(:lower).to_sym
      decs << "$#{camel_key}:#{@arg_types[camel_key]}"
    end
    unless @client_request.just_count?
      decs << ', $count: Int, '
      decs << '$page: Int'
    end
    debug("decs: #{decs}")
    decs
  end

  def query_header
    "query searchTag(#{var_declarations_from_params}) "
  end

  def variables_from_params
    vars = {}
    @params.keys.each do |key|
      camel_key = key.to_s.camelize(:lower).to_sym
      vars[camel_key] = @params[key]
    end
    unless @client_request.just_count?
      vars[:count] = @client_request.per_page
      vars[:page] = @client_request.page
    end
    debug("vars: #{vars.inspect}")
    vars.to_json.to_s
  end

  def query_body
    { query: query_header + query_string, variables: variables_from_params }
  end

  private

  def debug(msg)
    Rails.logger.debug("AdvancedNamesController::Index:Query: #{msg}")
  end
end
