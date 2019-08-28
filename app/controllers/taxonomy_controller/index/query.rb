# frozen_string_literal: true

# Constructs a Graphql taxonomy query request based on the client request.
# Uses variables, so needs to declare the variables.
class TaxonomyController::Index::Query
  QUERY_TYPE = 'filteredTaxonomy'

  def initialize(client_request)
    debug('initialize')
    @arg_types = TaxonomyController::Index::Utilities::Argument.new.types
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
    args << "count: #{@client_request.per_page},"
    args << "page: #{@client_request.page}"
    debug("args: #{args}")
    args
  end

  def query_string
    "{ #{QUERY_TYPE}(#{args_from_params}) #{query_data_structure} }"
  end

  #def query_data_structure
    #if @client_request.just_count?
      #NamesController::Index::Utilities::Count.new.data_structure
    #elsif @client_request.details?
      #NamesController::Index::Utilities::Detail.new(@client_request).data_structure
    #else
      #NamesController::Index::Utilities::List.new.data_structure
    #end
  #end

  def query_data_structure
    #if @client_request.just_count?
      #CountQuery.new(@client_request).query_string
    #elsif @client_request.details?
      #DetailQuery.new(@client_request).query_string
    #else
      #Rails.logger.debug('ListQuery.new(@client_request).query_string')
      #Rails.logger.debug(ListQuery.new(@client_request).query_string)
    #
    # TaxonomyController::Index::Utilities::List.new.data_structure
      TaxonomyController::Index::Utilities::ListQuery.new(@client_request).data_structure
    #end
  end

  def var_declarations_from_params
    decs = +''
    @params.keys.each do |key|
      decs << "$#{key.to_s.camelize(:lower).to_sym}:#{@arg_types[key]},"
    end
    debug("var_declarations_from_params - decs: #{decs.chop}")
    decs.chop
  end

  def query_header
    "query searchTag(#{var_declarations_from_params}) "
  end

  def variables_from_params
    vars = {}
    vars[:searchTerm] = @params[:search_term]
    #vars['count'] = @client_request.per_page
    #vars['page'] = @client_request.page
    debug("variables_from_params: #{vars.to_json.to_s}")
    vars.to_json.to_s
  end

  def query_body
    { query: query_header + query_string, variables: variables_from_params }
  end

  private

  def debug(msg)
    Rails.logger.debug("TaxonomyController::Index:Query: #{msg}")
  end
end
