class NameStatus < ActiveRecord::Base
  self.table_name = "name_status"
  self.primary_key = "id"
  has_many :names
end
