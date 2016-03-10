class NameType < ActiveRecord::Base
  self.table_name = "name_type"
  self.primary_key = "id"

  has_many :names
end
