class InstanceNotesForDetail < ActiveRecord::Base
  self.table_name = "instance_note"
  self.primary_key = "id"
  default_scope { where("instance_note_key_id in (select id from instance_note_key where not deprecated and name not like 'APC%') ") }

  belongs_to :instance
  belongs_to :instance_note_key
  belongs_to :name_detail, foreign_key: "instance_id"

  def apc_distribution?
    instance_note_key.apc_distribution?
  end

  def apc_comment?
    instance_note_key.apc_comment?
  end

  def marked_up_value
    value.gsub(/<IT>/,"<em>").gsub(/<RO>/,"</em> ")
  end
end
