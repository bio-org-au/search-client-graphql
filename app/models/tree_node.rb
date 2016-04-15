class TreeNode < ActiveRecord::Base
  self.table_name = "tree_node"
  self.primary_key = "id"
  belongs_to :tree_arrangement
  belongs_to :apc_tree_arrangement, -> { where label: 'APC' },
             class_name: "TreeArrangement", foreign_key: "tree_arrangement_id"
  belongs_to :name

  def self.apc(full_name)
    TreeNode.where(tree_arrangement_id: TreeArrangement.apc.id)
        .where.not(checked_in_at_id: nil)
        .where(next_node_id: nil)
        .joins(:name)
        .where(name: {full_name: full_name, duplicate_of_id: nil})
  end

  def self.apc?(full_name)
    self.apc(full_name).size == 1
  end
end
