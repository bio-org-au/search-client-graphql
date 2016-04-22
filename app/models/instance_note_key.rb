class InstanceNoteKey < ActiveRecord::Base
  self.table_name = "instance_note_key"
  self.primary_key = "id"

  belongs_to :instance_note_key

  def apc_comment?
    name.match(/APC Comment/)
  end

  def apc_distribution?
    name.match(/APC Dist./)
  end
end
