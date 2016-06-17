class NameDetailSynonym < ActiveRecord::Base
  self.table_name = "name_detail_synonyms_vw"
  belongs_to :name_detail, foreign_key: :cited_by_id

  def label
    case instance_type_name
    when 'misapplied'
      'misapplication'
    else
      instance_type_name
    end
  end
end
