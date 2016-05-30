class InstanceNoteKey < ActiveRecord::Base
  self.table_name = "instance_note_key"
  self.primary_key = "id"

  has_many :instance_notes
  has_many :instance_note_for_distributionss
  has_many :instance_note_for_type_specimens

  def apc_comment?
    name.match(/APC Comment/)
  end

  def apc_distribution?
    name.match(/APC Dist./)
  end
end
