class NameRank < ActiveRecord::Base
  self.table_name = "name_rank"
  self.primary_key = "id"
  has_many :names

  def self.species
    self.find_by(name: "Species")
  end

  def family?
    name == 'Familia'
  end

  def show?
    !visible_in_name && above_species?
  end

  def above_species?
    sort_order < NameRank.species.sort_order
  end
end
