class NameDetail < ActiveRecord::Base
  self.table_name = "name_details_vw"
  # Not a primary key!
  # But used as a primary key in the association.
  self.primary_key = "instance_id"

  has_many :name_detail_synonyms 
  scope :ordered, -> { order("coalesce(reference_year,9999), primary_instance desc, author_name") }

  def standalone?
    instance_standalone
  end

end
