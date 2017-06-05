# frozen_string_literal: true

# Rails model
class InstanceResourceVw < ActiveRecord::Base
  self.table_name = "instance_resource_vw"
  belongs_to :instance
end
