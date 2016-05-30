class ShardConfig < ActiveRecord::Base
  self.table_name = "shard_config"
  self.primary_key = "id"

  def self.classification_tree_label
    self.find_by(name: "classification tree label").value
  end
end
