# Model for a view to simplify querying.
class NameInstance < ActiveRecord::Base
  self.table_name = "name_instance_vw"
  self.primary_key = "id"
  belongs_to :instance
  belongs_to :reference
  belongs_to :name, foreign_key: :id
  has_one :rank, through: :name
  scope :simple_name_like, ->(string) { where("lower(name_simple_name) like lower(?) ", string.gsub(/\*/, "%").downcase) }
  scope :full_name_like, ->(string) { where("lower(name_full_name) like lower(?) ", string.gsub(/\*/, "%").downcase) }
  scope :scientific, -> { where("type_scientific") }
  scope :common, -> { where("type_name in ('common','informal')") }
  scope :cultivar, -> { where("type_cultivar") }
  scope :ordered, -> { order("name_sort_name, id, reference_year, primary_instance_first, synonym_full_name") }

  def self.simple_name_allow_for_hybrids_like(string)
    where("( lower(name_simple_name) like ? or lower(name_simple_name) like ?)",
          string.downcase.tr("*", "%").tr("×", "x"),
          Name.string_for_possible_hybrids(string)
         )
  end

  def self.full_name_allow_for_hybrids_like(string)
    Rails.logger.debug("NameInstance.full_name_allow_for_hybrids_like")
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
