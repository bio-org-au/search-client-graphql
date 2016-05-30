class NameDetail < ActiveRecord::Base
  self.table_name = "name_details_vw"
  # Not a primary key!
  # But used as a primary key in the association.
  self.primary_key = "instance_id"

  has_many :name_detail_synonyms 
  has_many :instance_notes, foreign_key: :instance_id 
  has_many :instance_note_for_type_specimens, foreign_key: :instance_id 
  has_one :instance_note_for_distribution, foreign_key: :instance_id 
  has_one :instance_note_for_comment, foreign_key: :instance_id 
  belongs_to :instance
  scope :ordered, -> { order("coalesce(reference_year,9999), primary_instance desc, author_name") }

  def standalone?
    instance_standalone
  end

end
