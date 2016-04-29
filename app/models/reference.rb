class Reference < ActiveRecord::Base
  self.table_name = "reference"
  self.primary_key = "id"
  has_many :instances
  has_many :synonyms
  has_many :cites
  has_many :name_or_synonyms
  has_many :accepted_names
  belongs_to :author
end
