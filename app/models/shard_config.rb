# frozen_string_literal: true

# Rails model
class ShardConfig < ActiveRecord::Base
  self.table_name = "shard_config"
  self.primary_key = "id"

  def self.classification_tree_label
    find_by(name: "classification tree label").value
  end
end
