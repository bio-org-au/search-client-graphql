# frozen_string_literal: true

# Rails model
class Instance < ActiveRecord::Base
  self.table_name = "instance"
  self.primary_key = "id"

  belongs_to :name
  belongs_to :instance_type
  belongs_to :reference
  belongs_to :this_is_cited_by,
             class_name: "Instance",
             foreign_key: "cited_by_id"
  belongs_to :this_cites,
             class_name: "Instance",
             foreign_key: "cites_id"
  has_many :instance_notes
  has_many :instance_notes_for_details, foreign_key: :instance_id
  has_many :instance_note_keys, through: :instance_notes
  has_many :instance_note_for_type_specimens
  has_one  :instance_note_for_distribution
  has_one  :instance_note_for_comment
  has_many :name_detail_commons
  has_one  :apc_comment, (lambda do
    where "instance_note_key_id = (select id from instance_note_key
          where name = 'APC Comment')"
  end),
           class_name: "InstanceNote", foreign_key: "instance_id"
  has_many :synonyms, foreign_key: "cited_by_id"
  has_one :accepted_name

  belongs_to :cited_by_instance, foreign_key: "cited_by_id"
  belongs_to :namespace
  has_one :instance_resource_vw

  scope :in_nested_instance_type_order, (lambda do
    order(
      "          case instance_type.name " \
      "          when 'basionym' then 1 " \
      "          when 'replaced synonym' then 2 " \
      "          when 'common name' then 99 " \
      "          when 'vernacular name' then 99 " \
      "          else 3 end, " \
      "          case nomenclatural " \
      "          when true then 99 " \
      "          else 2 end, " \
      "          case taxonomic " \
      "          when true then 2 " \
      "          else 1 end "
    )
  end)

  def sort_fields
    [reference.year || 9999,
     instance_type.primaries_first,
     reference.author.try("name") || "x"]
  end

  def standalone?
    cited_by_id.nil? && cites_id.nil?
  end

  def primary?
    instance_type.primary?
  end

  def apc_comment
    instance_notes.each do |note|
      return note.value if note.apc_comment?
    end
    nil
  end

  def apc_distribution
    instance_notes.each do |note|
      return note.value if note.apc_distribution?
    end
    nil
  end

  def has_protologue?
    instance_resource_vw.present?
  end

  def synonyms_for_display_just_commons
    synonyms.joins(:instance_type)
            .where("instance_type.name = 'common name'
                    or
                    instance_type.name = 'vernacular name'")
  end
end
