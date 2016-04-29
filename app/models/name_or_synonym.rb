class NameOrSynonym < ActiveRecord::Base
  self.table_name = "name_or_synonym_vw"
  self.primary_key = "id"
  SYNONYM = "synonym"
  belongs_to :status, class_name: "NameStatus", foreign_key: "name_status_id"
  belongs_to :rank, class_name: "NameRank", foreign_key: "name_rank_id"
  belongs_to :reference
  belongs_to :instance

  # "Union with Active Record"
  # http://thepugautomatic.com/2014/08/union-with-active-record/
  #
  # Gets past this error:
  #   ERROR:  bind message supplies 0 parameters, but 
  #   prepared statement "" requires 2
  #
  # See the explanation here: https://github.com/rails/rails/issues/13686
  def self.simple_name_like(search_term = 'x')
    query1 = AcceptedName.simple_name_like(search_term)
    query2 = AcceptedSynonym.simple_name_like(search_term)
    sql = NameOrSynonym.connection.unprepared_statement {
      "((#{query1.to_sql}) UNION (#{query2.to_sql})) AS name_or_synonym_vw"
    }
    NameOrSynonym.from(sql).order("sort_name")
  end

  def self.full_name_like(search_term = 'x')
    query1 = AcceptedName.full_name_like(search_term)
    query2 = AcceptedSynonym.full_name_like(search_term)
    sql = NameOrSynonym.connection.unprepared_statement {
      "((#{query1.to_sql}) UNION (#{query2.to_sql})) AS name_or_synonym_vw"
    }
    NameOrSynonym.from(sql).order("sort_name")
  end

  def accepted_accepted?
    type_code == "ApcConcept"
  end

  def accepted_excluded?
    type_code == "ApcExcluded"
  end

  def synonym?
    type_code == "synonym"
  end

  def show_status?
    status.show?
  end

end
