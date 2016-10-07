# frozen_string_literal: true

# Rails model
class NameTreePathDefault < ActiveRecord::Base
  self.table_name = "name_tree_path"
  self.primary_key = "id"
  default_scope do
    where("tree_id = (select id from tree_arrangement where label = 'APNI') ")
  end
  belongs_to :name

  def family_name
    return "" unless rank_path =~ /Familia:.*>/
    rank_path.sub(/.*Familia:/, "").sub(/>.*$/, "")
  rescue
    "unknown"
  end
end
