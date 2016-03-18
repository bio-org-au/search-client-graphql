class Apni::Search::Parse
  attr_reader :search_type,
              :search_term,
              :show_details,
              :show_as

  SIMPLE_SEARCH = "Search"
  SHOW_DETAILS = "details"

  def initialize(params, info = {})
    if info.has_key?(:search_type) 
      @search_type = "#{info[:search_type]} Search"
    else
      @search_type = SIMPLE_SEARCH
    end
    @search_term = params[:q].strip.gsub(/\*/,'%')
    @show_as = params[:show_results_as] || info[:default_show_results_as]
    @show_details = @show_as == SHOW_DETAILS
  end
end
