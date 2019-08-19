# frozen_string_literal: true

# Simple version of a filtered search using a realisistic filter type
class FilteredSearchController < ApplicationController
  DATA_SERVER = Rails.configuration.data_server
  def index
    define_arg_types
    simulate_params
    the_result = result
    render plain: 'We have a problem.' if @severe_error
    return if @severe_error

    if the_result.errors.blank?
      render plain: the_result
    else
      render plain: the_result.errors.first.message
    end
  end

  # simulate params
  def simulate_params
    hash = {}
    hash['searchTerm'] = 'fred'
    hash['authorAbbrev'] = 'Br.'
    hash['family'] = 'some family'
    @params = hash
  end

  def var_declarations
    dec_s = +''
    @params.keys.each do |key|
      dec_s << "$#{key}: #{@arg_types[key]} "
    end
    dec_s
  end

  # How to work this out from the server?
  def define_arg_types
    hash = {}
    hash['searchTerm'] = 'String'
    hash['authorAbbrev'] = 'String'
    hash['exAuthorAbbrev'] = 'String'
    hash['baseAuthorAbbrev'] = 'String'
    hash['exBaseAuthorAbbrev'] = 'String'
    hash['family'] = 'String'
    hash['genus'] = 'String'
    hash['species'] = 'String'
    hash['rank'] = 'String'
    hash['includeRanksBelow'] = 'Boolean'
    hash['publication'] = 'String'
    hash['isoPublicationDate'] = 'String'
    hash['protologue'] = 'String'
    hash['nameElement'] = 'String'
    hash['typeOfName'] = 'String'
    hash['scientificName'] = 'Boolean'
    hash['scientificAutonymName'] = 'Boolean'
    hash['scientificNamedHybridName'] = 'Boolean'
    hash['scientificHybridFormulaName'] = 'Boolean'
    hash['cultivarName'] = 'Boolean'
    hash['commonName'] = 'Boolean'
    hash['typeNoteText'] = 'String'
    hash['typeNoteKeys'] = '[String]'
    hash['orderByName'] = 'Boolean'
    @arg_types = hash
  end

  def query_header
    "query searchTag(#{var_declarations}) "
  end

  # Automate stringifying query key placeholders from params
  # e.g. Manually, it'd be like this
  # arg_s = 'searchTerm: $searchTerm, '
  # arg_s << 'authorAbbrev: $authorAbbrev, '
  # arg_s << 'orderByName: $orderByName '
  def args
    arg_s = +''
    @params.each_key do |key|
      arg_s << "#{key}: $#{key},"
    end
    "filter: { #{arg_s.sub(/, *$/, '')} }"
  end

  def query_type
    'filteredSearch'
  end

  def query_string
    "{#{query_type}(#{args}) { data }}"
  end

  def body
    { query: query_header + query_string, variables: @params.to_json.to_s }
  end

  def result
    @severe_error = false
    response = HTTParty.post("#{DATA_SERVER}/v1",
                             body: body,
                             timeout: 30)
    Rails.logger.debug("FilteredSearch::result response.body: #{response.body}")
    error("#{response.code}: #{response}") unless response.code == 200
    JSON.parse(response.to_s, object_class: OpenStruct)
  rescue RuntimeError => e
    Rails.logger.error(e.to_s)
    @severe_error = true
  end

  private

  def error(msg)
    Rails.logger.error(msg)
  end
end
