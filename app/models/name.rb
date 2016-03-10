class Name < ActiveRecord::Base
  self.table_name = "name"
  self.primary_key = "id"
  belongs_to :name_rank
  belongs_to :name_type
end
