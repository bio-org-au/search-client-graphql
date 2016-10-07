# frozen_string_literal: true

# Rails model
class InstanceNoteForDistribution < ActiveRecord::Base
  self.table_name = "instance_note"
  self.primary_key = "id"
  default_scope do
    where("instance_note_key_id = (select id from instance_note_key
           where name = 'APC Dist.') ")
  end

  belongs_to :instance
  belongs_to :instance_note_key
  belongs_to :name_detail, foreign_key: "instance_id"
  belongs_to :name_instance_name_tree_path, foreign_key: "instance_id"
end
