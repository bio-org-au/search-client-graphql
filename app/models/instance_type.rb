# frozen_string_literal: true

# Rails model
class InstanceType < ActiveRecord::Base
  self.table_name = "instance_type"
  self.primary_key = "id"
  has_many :instances
  has_many :synonyms

  def primaries_first
    primary_instance ? "A" : "B"
  end

  def primary?
    primary_instance
  end

  def protologue?
    protologue
  end

  def misapplied?
    misapplied == true
  end

  def doubtful?
    doubtful == true
  end

  def pro_parte?
    pro_parte == true
  end

  def common_or_vernacular?
    name == "common name" || name == "vernacular name"
  end

  def main_sort
    case name
    when "basionym"
      1
    when "replaced synonym"
      2
    when "common name"
      99
    when "vernacular name"
      99
    else
      3
    end
  end
  
  def nom_tax_sort
    case nomenclatural
    when true
      1
    else
      2
    end
  end

  def cited_by_preposition
    if name.downcase =~ /misapplied/
      "to"
    else
      "of"
    end
  end

  def shows_reference_it_cites?
    name.match("misapplied")
  end
end
