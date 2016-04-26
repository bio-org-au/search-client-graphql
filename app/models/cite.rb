class Cite < ActiveRecord::Base
  self.table_name = "instance"
  self.primary_key = "id"
  has_many :synonyms, foreign_key: "cites_id"
  belongs_to :reference
end
