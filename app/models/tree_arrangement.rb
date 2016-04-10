class TreeArrangement < ActiveRecord::Base
  self.table_name = "tree_arrangement"
  self.primary_key = "id"
  belongs_to :tree_node
  has_many :name_tree_paths, foreign_key: "tree_id"
  has_many :names, through: :name_tree_paths

  def self.apc
    self.find_by(description: "Australian Plant Census")
  end
end
