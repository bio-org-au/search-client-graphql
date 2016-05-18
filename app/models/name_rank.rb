class NameRank < ActiveRecord::Base
  self.table_name = "name_rank"
  self.primary_key = "id"
  has_many :names
  has_many :name_or_synonyms
  belongs_to :name_group

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

  def self.above_species?(rank_sort_order)
    rank_sort_order < NameRank.species.sort_order
  end

  def self.show?(rank_name,rank_visible_in_name,rank_sort_order)
    !rank_visible_in_name && NameRank.above_species?(rank_sort_order)
  end
end
