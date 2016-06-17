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

  def misapplied?
    name.match(/\Amisapplied\z/i)
  end

  def cited_by_preposition
    if name.downcase.match(/misapplied/)
      "to"
    else
      "of"
    end
  end

  def shows_reference_it_cites?
    name.match('misapplied')
  end
end
