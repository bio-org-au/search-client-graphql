class Instance < ActiveRecord::Base
  self.table_name = "instance"
  self.primary_key = "id"
  belongs_to :name
  belongs_to :instance_type
  belongs_to :reference
  belongs_to :this_is_cited_by,
             class_name: "Instance",
             foreign_key: "cited_by_id"
  has_many :instance_notes

  belongs_to :cited_by_instance, foreign_key: "cited_by_id"

  scope :in_nested_instance_type_order, lambda {
    order(
      "          case instance_type.name " \
      "          when 'basionym' then 1 " \
      "          when 'replaced synonym' then 2 " \
      "          when 'common name' then 99 " \
      "          when 'vernacular name' then 99 " \
      "          else 3 end, " \
      "          case nomenclatural " \
      "          when true then 1 " \
      "          else 2 end, " \
      "          case taxonomic " \
      "          when true then 2 " \
      "          else 1 end ")
  }

  def sort_fields
    [reference.year || 9999,
     instance_type.primaries_first,
     reference.author.try("name") || "x"]
  end

  def standalone?
    cited_by_id.nil? && cites_id.nil?
  end

  def self.records_cited_by_standalone(instance)
    Instance.joins(:instance_type, :name, :reference)
      .where(cited_by_id: instance.id)
      .in_nested_instance_type_order
      .order("reference.year,lower(name.full_name)")
  end

  def self.records_cited_by_relationship(instance)
    Instance.joins(:instance_type)
      .where(cited_by_id: instance.id)
      .in_nested_instance_type_order
  end

  def primary?
    instance_type.primary?
  end

  def apc_comment
    instance_notes.each do | note | 
      return note.value if note.apc_comment?
    end
    return nil
  end

  def apc_distribution
    instance_notes.each do | note | 
      return note.value if note.apc_distribution?
    end
    return nil
  end
end
