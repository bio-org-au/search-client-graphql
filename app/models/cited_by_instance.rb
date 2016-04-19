class CitedByInstance < ActiveRecord::Base
  self.table_name = "instance"
  self.primary_key = "id"
  belongs_to :name
  belongs_to :instance_type
  belongs_to :reference
  has_many :instances,
             foreign_key: "cited_by_id"
  belongs_to :cited_by_name, foreign_key: "name_id"
  has_many :cited_by_instance_tree_nodes,
             foreign_key: "instance_id"
end
