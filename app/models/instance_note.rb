class InstanceNote < ActiveRecord::Base
  self.table_name = "instance_note"
  self.primary_key = "id"

  belongs_to :instance
  belongs_to :instance_note_key

  def apc_distribution?
    instance_note_key.apc_distribution?
  end

  def apc_comment?
    instance_note_key.apc_comment?
  end
end
