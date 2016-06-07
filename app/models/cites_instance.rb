class CitesInstance < ActiveRecord::Base
  self.table_name = "instance"
  self.primary_key = "cites_id"
  belongs_to :name
  belongs_to :instance_type
  belongs_to :reference
  has_many   :cites, class_name: "Instance", foreign_key: "id"
end
