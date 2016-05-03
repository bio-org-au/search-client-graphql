class NameInstance < ActiveRecord::Base
  self.table_name = "name_instance_vw"
  self.primary_key = "id"
  scope :simple_name_like, ->(string) { where("lower(simple_name) like lower(?) ", string.gsub(/\*/, "%").downcase) }
  scope :full_name_like, ->(string) { where("lower(full_name) like lower(?) ", string.gsub(/\*/, "%").downcase) }
  scope :scientific, -> { where("type_scientific") }
  scope :ordered, -> { order("sort_name, reference_year, primary_instance_first, synonym_full_name") }

  def show_status?
    NameStatus.show?(status_name)
  end

  def show_rank?
    NameRank.show?(rank_name,rank_visible_in_name,rank_sort_order)
  end
end
