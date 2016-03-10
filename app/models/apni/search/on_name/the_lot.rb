# Seach all names.
# Cannot call this class "All" because it causes an error,
# so using "TheLot" as a rough synonym.
class Apni::Search::OnName::TheLot
  attr_reader :parsed,
              :results
  SEARCH_TYPE = "All Name".freeze
  def initialize(params)
    @parsed = Apni::Search::Parse.new(params, search_type: SEARCH_TYPE)
    @results = Name.where(["lower(simple_name) like lower(?)",
                           @parsed.search_term])
                   .order(:full_name)
    if @results.empty?
      @results = Name.where(["lower(full_name) like lower(?)",
                             @parsed.search_term])
                     .order(:full_name)
    end
  end
end
