# Model for a view to simplify querying.
# The view joins to name_tree_path to provide access to family name encoded
# in the rank_path.
class NameInstanceNameTreePath < ActiveRecord::Base
  self.table_name = "name_instance_name_tree_path_vw"
  self.primary_key = "id"
  belongs_to :instance
  belongs_to :reference
  belongs_to :name, foreign_key: :id
  has_one :rank, through: :name
  has_many :instance_note_for_type_specimens, through: :instance
  has_many :instance_note_for_distributions, through: :instance
  scope :simple_name_like, ->(string) { where("lower(name_simple_name) like lower(?) ", string.gsub(/\*/, "%").downcase) }
  scope :full_name_like, ->(string) { where("lower(name_full_name) like lower(?) ", string.gsub(/\*/, "%").downcase) }
  scope :scientific, -> { where("type_scientific") }
  scope :common, -> { where("type_name in ('common','informal')") }
  scope :cultivar, -> { where("type_cultivar") }
  scope :ordered, -> { order("family_name, name_sort_name, id, reference_year, primary_instance_first, synonym_full_name") }

  def self.search_for(string)
    where("( lower(name_simple_name) like ? or lower(name_simple_name) like ? or lower(name_full_name) like ? or lower(name_full_name) like ?)",
          string.downcase.tr("*", "%").tr("×", "x"),
          Name.string_for_possible_hybrids(string),
          string.downcase.tr("*", "%").tr("×", "x"),
          Name.string_for_possible_hybrids(string)
         )
  end

  def self.simple_name_allow_for_hybrids_like(string)
    where("( lower(name_simple_name) like ? or lower(name_simple_name) like ?)",
          string.downcase.tr("*", "%").tr("×", "x"),
          Name.string_for_possible_hybrids(string)
         )
  end

  def self.full_name_allow_for_hybrids_like(string)
    Rails.logger.debug("NameInstanceNameTreePath.full_name_allow_for_hybrids_like")
    where("( lower(name_full_name) like ? or lower(name_full_name) like ?)",
          string.downcase.tr("*", "%").tr("×", "x"),
          Name.string_for_possible_hybrids(string)
         )
  end

  def show_status?
    NameStatus.show?(status_name)
  end

  def show_rank?
    NameRank.show?(rank_name,rank_visible_in_name,rank_sort_order)
  end
  
  def ordered
    self.instances.sort do |x, y|
      x.sort_fields <=> y.sort_fields
    end
  end

  def standalone?
    instance_standalone
  end
end
