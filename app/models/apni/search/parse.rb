class Apni::Search::Parse
  attr_reader :search_type,
              :search_term,
              :show_details

  SIMPLE_SEARCH = "Search"

  def initialize(params, info = {})
    if info.has_key?(:search_type) 
      @search_type = "#{info[:search_type]} Search"
    else
      @search_type = SIMPLE_SEARCH
    end
    @search_term = params[:q].strip.gsub(/\*/,'%')
    @show_details = params[:details] == 'true'
  end
end
