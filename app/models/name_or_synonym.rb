# frozen_string_literal: true

# Rails model
class NameOrSynonym < ActiveRecord::Base
  self.table_name = "name_or_synonym_vw"
  self.primary_key = "id"
  SYNONYM = "synonym"
  belongs_to :status, class_name: "NameStatus", foreign_key: "name_status_id"
  belongs_to :rank, class_name: "NameRank", foreign_key: "name_rank_id"
  belongs_to :reference
  belongs_to :instance
  belongs_to :synonym_type,
             class_name: "InstanceType",
             foreign_key: :synonym_type_id
  belongs_to :synonym_ref, class_name: "Reference", foreign_key: :synonym_ref_id
  belongs_to :synonym_name, class_name: "Name", foreign_key: :id
  belongs_to :synonym_cites,
             class_name: "Instance",
             foreign_key: :cites_instance_id

  # "Union with Active Record"
  # http://thepugautomatic.com/2014/08/union-with-active-record/
  #
  # Gets past this error:
  #   ERROR:  bind message supplies 0 parameters, but
  #   prepared statement "" requires 2
  #
  # See the explanation here: https://github.com/rails/rails/issues/13686
  def self.simple_name_like(search_term = "x")
    query1 = AcceptedName.simple_name_like(search_term)
    query2 = AcceptedSynonym.simple_name_like(search_term)
    sql = NameOrSynonym.connection.unprepared_statement do
      "((#{query1.to_sql}) UNION (#{query2.to_sql})) AS name_or_synonym_vw"
    end
    NameOrSynonym.from(sql).order("sort_name")
  end

  def self.full_name_like(search_term = "x")
    query1 = AcceptedName.full_name_like(search_term)
    query2 = AcceptedSynonym.full_name_like(search_term)
    sql = NameOrSynonym.connection.unprepared_statement do
      "((#{query1.to_sql}) UNION (#{query2.to_sql})) AS name_or_synonym_vw"
    end
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

  def to_csv
    attributes.values_at(*Name.columns.map(&:name))
    [full_name, status.name].to_csv
  end
end
