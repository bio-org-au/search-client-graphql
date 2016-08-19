# frozen_string_literal: true
class NameTreePathDefault < ActiveRecord::Base
  self.table_name = "name_tree_path"
  self.primary_key = "id"
  default_scope { where("tree_id = (select id from tree_arrangement where label = 'APNI') ") }
  belongs_to :name

  def family_name
    return "" unless rank_path =~ /Familia:.*>/
    rank_path.sub(/.*Familia:/, "").sub(/>.*$/, "")
  rescue => e
    "unknown"
  end
end
