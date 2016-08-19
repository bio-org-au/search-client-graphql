# frozen_string_literal: true
class CitedByInstanceTreeNode < ActiveRecord::Base
  self.table_name = "tree_node"
  self.primary_key = "id"
  belongs_to :cited_by_instance_tree_arrangement, -> { where label: "APC" },
             class_name: "TreeArrangement",
             foreign_key: "tree_arrangement_id"
  belongs_to :cited_by_instance, foreign_key: "instance_id"
  belongs_to :name
  belongs_to :cited_by_instance_tree_node_name, class_name: "Name", foreign_key: "name_id"
  has_one    :cited_by_instance_tree_node_name_tree_path, foreign_key: "name_id"
end
