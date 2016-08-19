# frozen_string_literal: true
class InstanceThatCites < ActiveRecord::Base
  self.table_name = "instances_that_cite_vw"
  belongs_to :name_detail, foreign_key: :cites_id
end
