class Reference < ActiveRecord::Base
  self.table_name = "reference"
  self.primary_key = "id"
  has_many :instances
  has_many :synonyms
  has_many :cites
  belongs_to :author
end
