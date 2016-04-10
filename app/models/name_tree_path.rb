class NameTreePath < ActiveRecord::Base
  self.table_name = "name_tree_path"
  self.primary_key = "id"

  belongs_to :name
  belongs_to :tree_arrangement, foreign_key: "tree_id"
end
