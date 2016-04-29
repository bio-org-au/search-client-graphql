class AcceptedSynonym < ActiveRecord::Base
  self.table_name = "accepted_synonym_vw"
  self.primary_key = "id"
  scope :simple_name_like, ->(string) { where("lower((simple_name)) like lower((?)) ", string.gsub(/\*/, "%").downcase) }
  scope :full_name_like, ->(string) { where("lower((full_name)) like lower((?)) ", string.gsub(/\*/, "%").downcase) }
  scope :default_ordered, -> { order("lower(simple_name)") }
end
