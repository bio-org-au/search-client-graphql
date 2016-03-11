class Reference < ActiveRecord::Base
  self.table_name = "reference"
  self.primary_key = "id"
  has_many :instances
  belongs_to :author
end
