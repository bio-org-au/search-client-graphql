class Apni::Search::Parse
  attr_reader :search_type,
              :search_term

  SIMPLE_SEARCH = "APNI Search"

  def initialize(params)
    @search_type = SIMPLE_SEARCH
    @search_term = params[:q]
  end
end
