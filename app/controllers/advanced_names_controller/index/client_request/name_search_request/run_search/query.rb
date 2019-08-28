# frozen_string_literal: true

# Constructs a Graphql name query request based on the client request query.
# Uses variables, so needs to declare the variables.
class AdvancedNamesController::Index::ClientRequest::NameSearchRequest::RunSearch::Query
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
    args << "filter: {#{filter}}, "
    args << "count: 3, " # #{@client_request.per_page},"
    args << "page: 2 " # #{@client_request.page}"
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
      decs << "$#{key.to_s.camelize(:lower).to_sym}:#{@arg_types[key]}, "
    end
    #decs << '$limit: Int, '
    #decs << '$offset: Int'
    debug("decs: #{decs}")
    decs
  end

  def query_header
    "query searchTag(#{var_declarations_from_params}) "
  end

  def zvariables_from_params
    debug(%Q(variables_from_params vars: {"search_term":"fred","scientific_name":true}))
    %q({"searchTerm":"fred"})
  end

  def variables_from_params
    vars = @params
    vars['count'] = @client_request.per_page
    vars['offset'] = @client_request.offset
    debug("variables_from_params vars: #{vars.to_json.to_s}")
    vars.to_json.to_s
  end

  def xvariables_from_params
    vars = +''
    @params.each do |key, value|
      if key.to_s == 'search_term'
        value = 'Banksia spinulosa'
      end
      vars << "$#{key.to_s.camelize(:lower)}:#{value}, "

    end
    #vars['limit'] = @client_request.limit
    #vars['offset'] = @client_request.offset
    debug("variables_from_params vars: #{vars.to_json.to_s}")
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
