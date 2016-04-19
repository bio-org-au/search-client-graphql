#  Name object methods
class CitedByName < ActiveRecord::Base
  self.table_name = "name"
  self.primary_key = "id"

  has_many :cited_bys, foreign_key: "name_id"


end
