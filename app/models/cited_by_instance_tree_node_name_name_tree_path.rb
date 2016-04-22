class CitedByInstanceTreeNodeNameNameTreePath < ActiveRecord::Base
  self.table_name = "name_tree_path"
  self.primary_key = "id"

  belongs_to :cited_by_instance_tree_node_name, class_name: "Name", foreign_key: :name_id
end
