class Author < ActiveRecord::Base
  self.table_name = "instance"
  self.primary_key = "id"
  has_many :references
end
