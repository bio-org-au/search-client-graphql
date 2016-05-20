#  Name object methods
class NameSearch < ActiveRecord::Base
  self.table_name = "name"

  def self.simple_name_list_search(search_term)
    NameSearch.list_search.simple_name_allow_for_hybrids_like(search_term)
  end

  def self.full_name_list_search(search_term)
    NameSearch.list_search.full_name_allow_for_hybrids_like(search_term)
  end

  def self.simple_name_detail_search(search_term)
    NameSearch.detail_search.simple_name_like(search_term)
  end

  def self.list_search
    Name.scientific_search
        .joins(:name_type)
        .where(name_type: { scientific: true })
  end

  def self.detail_search
    NameInstance.scientific.ordered
  end

end
