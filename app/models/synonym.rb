class Synonym < ActiveRecord::Base
  self.table_name = "instance"
  self.primary_key = "id"
  belongs_to :instance, foreign_key: "cited_by_id"
  belongs_to :name
  belongs_to :reference
  belongs_to :cite, foreign_key: "cites_id"
  belongs_to :instance_type
end

