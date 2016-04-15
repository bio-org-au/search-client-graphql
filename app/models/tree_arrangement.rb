class TreeArrangement < ActiveRecord::Base
  self.table_name = "tree_arrangement"
  self.primary_key = "id"
  has_many :tree_nodes
  has_many :name_tree_paths, foreign_key: "tree_id"
  has_many :names, through: :tree_nodes

  def self.apc
    self.find_by(description: "Australian Plant Census")
  end
end
