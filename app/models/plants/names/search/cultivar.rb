#  Search for cultivar names
class Plants::Names::Search::Cultivar
  attr_reader :parsed,
              :results
  SEARCH_TYPE = "Cultivar Name".freeze
  def initialize(params, default_show_results_as: "list")
    @parsed = Plants::Names::Search::Parse.new(params,
                                      search_type: SEARCH_TYPE,
                                      default_show_results_as:
                                        default_show_results_as)
    @results = simple_name_search
    return unless @results.empty?
    @results = full_name_search
  end

  def simple_name_search
    Rails.logger.debug("cultivar simple_name_search")
    if @parsed.list?
      Rails.logger.debug("cultivar simple_name_search for list")
      list_search.simple_name_allow_for_hybrids_like(@parsed.search_term)
    else
      Rails.logger.debug("cultivar simple_name_search for details")
      detail_search.simple_name_allow_for_hybrids_like(@parsed.search_term)
    end
  end

  def full_name_search
    Rails.logger.debug("cultivar full_name_search")
    if @parsed.list?
      Rails.logger.debug("cultivar full_name_search for list")
      list_search.full_name_allow_for_hybrids_like(@parsed.search_term)
    else
      Rails.logger.debug("cultivar full_name_search for details")
      detail_search.full_name_allow_for_hybrids_like(@parsed.search_term)
    end
  end

  def list_search
    Name.cultivar_search
        .joins(:name_type)
        .where(name_type: { cultivar: true })
  end

  def detail_search
    NameInstance.cultivar.ordered
  end


  def xsimple_name_search
    name_search.lower_simple_name_like(@parsed.search_term)
  end

  def xfull_name_search
    name_search.lower_full_name_like(@parsed.search_term)
  end

  def xname_search
    Name.scientific_search
        .joins(:name_type)
        .where(name_type: { cultivar: true })
  end
end#  Search for cultivar names
