class CitedByInstanceTreeNode < ActiveRecord::Base
  self.table_name = "tree_node"
  self.primary_key = "id"
  belongs_to :cited_by_instance_tree_arrangement, -> { where label: 'APC' },
             class_name: "TreeArrangement",
             foreign_key: "tree_arrangement_id"
  belongs_to :cited_by_instance, foreign_key: "instance_id"

end
