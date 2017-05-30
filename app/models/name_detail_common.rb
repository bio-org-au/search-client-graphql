# frozen_string_literal: true

# Rails model
class NameDetailCommon < ActiveRecord::Base
  self.table_name = "name_detail_commons_vw"
  belongs_to :name_detail, foreign_key: :cited_by_id
  belongs_to :instance, foreign_key: :cited_by_id
end
