# frozen_string_literal: true
class CitedByInstanceTreeArrangement < ActiveRecord::Base
  self.table_name = "tree_arrangement"
  self.primary_key = "id"
  has_many :cited_by_instance_tree_nodes, foreign_key: "tree_arrangement_id"
  has_many :name_tree_paths, foreign_key: "tree_id"
  has_many :names, through: :tree_nodes

  def self.apc
    find_by(description: "Australian Plant Census")
  end
end
