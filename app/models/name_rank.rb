class NameRank < ActiveRecord::Base
  self.table_name = "name_rank"
  self.primary_key = "id"
  has_many :names

  def family?
    name == 'Familia'
  end
end