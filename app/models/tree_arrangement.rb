class TreeArrangement < ActiveRecord::Base
  self.table_name = "tree_arrangement"
  self.primary_key = "id"
  belongs_to :tree_node

  def self.apc
    self.find_by(description: "Australian Plant Census")
  end
end
