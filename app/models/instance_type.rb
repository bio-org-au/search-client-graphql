class InstanceType < ActiveRecord::Base
  self.table_name = "instance_type"
  self.primary_key = "id"
  has_many :instances

  def primaries_first
    primary_instance ? "A" : "B"
  end

  def primary?
    primary_instance
  end
end
