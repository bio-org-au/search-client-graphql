# frozen_string_literal: true

# Rails model
class CitedBy < ActiveRecord::Base
  self.table_name = "instance"
  self.primary_key = "id"
  has_many :name_details
  belongs_to :name
  belongs_to :instance_type
  belongs_to :reference
end
