
class HelloController < ApplicationController
  DATA_SERVER = Rails.configuration.data_server
  def index
    the_result = result
    render plain: 'We have a problem.' if @severe_error
    return if @severe_error
    unless the_result.errors.blank?
      render plain: the_result.errors.first.message
    else
      render plain: the_result
    end
  end

  def var_declarations
    declarations_s = "$searchTerm: String, "
    declarations_s << "$authorAbbrev: String "
    declarations_s
  end

  def query_header
    "query searchTag(#{var_declarations}) "
  end

  def args
    arg_s = "searchTerm: $searchTerm, "
    arg_s << "authorAbbrev: $authorAbbrev "
  end

  def query_type
    'helloArgVars'
  end

  def query_string
    "{#{query_type}(#{args})}"
  end

  def var_hash
    hash = Hash.new
    hash["searchTerm"] = "jedijoe"
    hash["authorAbbrev"] = "freddy"
    hash
  end

  def body
    { query: query_header + query_string, variables: var_hash.to_json.to_s }
  end

  def result
    @severe_error = false
    response = HTTParty.post("#{DATA_SERVER}/v1",
                         body: body,
                         timeout: 30)
    Rails.logger.debug(response.code)
    Rails.logger.debug("HelloController::result: #{response.body}")
    Rails.logger.error(response.code) unless response.code == 200
    Rails.logger.error(response.to_s)  unless response.code == 200
    JSON.parse(response.to_s, object_class: OpenStruct)
  rescue => e
    Rails.logger.error(e.to_s)
    @severe_error = true
  end
end


#  curl   -X POST   -H "Content-Type: application/json"
#  --data '{ "query": " query blah($searchTerm: String) { helloArgVars(searchTerm: $searchTerm) }", "variables": "{ \"searchTerm\": \"jedi\"}" }'   
#  http://localhost:2004/v1; echo "^M"; echo "^M"; echo "^M"
#  
#  {"data":{"helloArgVars":"searchTerm: jedi; "}}
