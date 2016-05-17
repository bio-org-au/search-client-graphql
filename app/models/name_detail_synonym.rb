class NameDetailSynonym < ActiveRecord::Base
  self.table_name = "name_detail_synonyms_vw"
  belongs_to :name_detail, foreign_key: :cited_by_id
end
