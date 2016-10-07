# frozen_string_literal: true

# Rails model
class NameDetailSynonym < ActiveRecord::Base
  self.table_name = "name_detail_synonyms_vw"
  belongs_to :name_detail, foreign_key: :cited_by_id
  belongs_to :cites, class_name: "Instance", foreign_key: :cites_id

  def label
    instance_type_name.sub(/misapplied/, "misapplication")
  end

  def shows_cites_reference?
    instance_type_name.match(/\Amisapplied\z/)
  end
end
