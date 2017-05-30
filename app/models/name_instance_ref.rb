# frozen_string_literal: true

# Rails model for a view
class NameInstanceRef < ActiveRecord::Base
  self.table_name = "name_instances_refs_vw"
  # Not actually a primary key,
  # but used as a primary key in the association.
  self.primary_key = "instance_id"

  belongs_to :name
  belongs_to :instance_type
  has_many :instance_notes, foreign_key: :instance_id
  has_many :instance_note_for_type_specimens, foreign_key: :instance_id
  has_many :instance_notes_for_details, foreign_key: :instance_id
  has_one :instance_note_for_distribution, foreign_key: :instance_id
  has_one :instance_note_for_comment, foreign_key: :instance_id
  belongs_to :instance
  scope :ordered, (lambda do
    order("coalesce(reference_year,9999), primary_instance desc, author_name")
  end)

  def standalone?
    instance_standalone
  end

  def distribution?
    instance_note_for_distribution.present?
  end

  def distribution
    instance_note_for_distribution.try("value")
  end

  def comment?
    instance_note_for_comment.present?
  end

  def comment
    instance_note_for_comment.try("value")
  end
end
