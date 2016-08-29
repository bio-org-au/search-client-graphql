# frozen_string_literal: true
#  Name object methods
class Name < ActiveRecord::Base
  self.table_name = "name"
  self.primary_key = "id"
  acts_as_tree
  belongs_to :author
  belongs_to :rank, class_name: "NameRank", foreign_key: "name_rank_id"
  belongs_to :status, class_name: "NameStatus", foreign_key: "name_status_id"
  belongs_to :name_type
  belongs_to :namespace
  has_many :instances
  has_many :instance_types, through: :instances
  has_many :references, through: :instances
  has_many :synonyms, through: :instances
  has_many :authors, through: :references
  has_many :tree_nodes
  has_many :name_tree_paths
  has_one  :name_tree_path_default

  has_many :apni_tree_arrangements, through: :apni_name_tree_paths
  has_many :apni_name_tree_paths, class_name: "NameTreePath"

  has_many :apc_tree_nodes, (lambda do
                               where "next_node_id is null
                               and checked_in_at_id is not null"
                             end),
           class_name: "TreeNode"
  has_many :apc_tree_arrangements, through: :apc_tree_nodes

  has_one :apc_accepted_tree_node, (lambda do
                                      where "next_node_id is null
                                      and checked_in_at_id is not null
                                      and type_uri_id_part = 'ApcConcept'"
                                    end),
          class_name: "TreeNode"
  has_one :apc_accepted_instance, through: :apc_accepted_tree_node

  has_one :apc_excluded_tree_node, (lambda do
    where "next_node_id is null
    and checked_in_at_id is not null
    and type_uri_id_part = 'ApcExcluded'"
  end),
          class_name: "TreeNode"
  has_one :apc_excluded_instance, through: :apc_excluded_tree_node

  has_many :cited_by_instances, through: :instances
  has_many :cited_by_names, through: :cited_by_instances
  has_many :cited_by_instance_tree_nodes, through: :cited_by_instances
  has_many :cited_by_instance_tree_arrangements,
           through: :cited_by_instance_tree_nodes

  has_many :cited_by_instance_tree_node_names,
           through: :cited_by_instance_tree_nodes
  has_many :cited_by_instance_tree_node_name_name_tree_paths,
           through: :cited_by_instances
  has_one :accepted_name, foreign_key: :id
  has_many :name_instance_name_tree_paths, foreign_key: :id
  scope :not_a_duplicate, -> { where(duplicate_of_id: nil) }
  scope :has_an_instance, (lambda do
    where(["exists (select null
           from instance
           where name.id = instance.name_id)"])
  end)
  scope :lower_full_name_like, (lambda do |string|
                                  where("lower(f_unaccent(name.full_name))
                                        like f_unaccent(?) ",
                                        string.tr("*", "%").downcase)
                                end)
  scope :lower_simple_name_like, (lambda do |string|
                                    where("lower(name.simple_name) like ? ",
                                          string.tr("*", "%").downcase)
                                  end)
  scope :ordered, -> { order("sort_name") }
  scope :ordered_scientifically, (lambda do
                                    order("coalesce(trim( trailing '>'
                                          from substring(substring(
                                          name_tree_path.rank_path from
                                          'Familia:[^>]*>') from 9)),
                                          'A'||to_char(name_rank.sort_order,
                                          '0009')), sort_name,
                                          name_rank.sort_order")
                                  end)
  scope :limited_high, -> { limit(5000) }

  def self.search_for(string)
    where("( lower(name.simple_name) like ?
          or lower(name.simple_name) like ?
          or lower(f_unaccent(name.full_name)) like ?
          or lower(f_unaccent(name.full_name)) like ?)",
          string.downcase.tr("*", "%").tr("×", "x"),
          Name.string_for_possible_hybrids(string),
          string.downcase.tr("*", "%").tr("×", "x"),
          Name.string_for_possible_hybrids(string))
  end

  def self.simple_name_allow_for_hybrids_like(string)
    where("( lower(name.simple_name) like ? or lower(name.simple_name) like ?)",
          string.downcase.tr("*", "%").tr("×", "x"),
          Name.string_for_possible_hybrids(string))
  end

  def self.full_name_allow_for_hybrids_like(string)
    where("( lower(f_unaccent(name.full_name)) like ?
          or lower(f_unaccent(name.full_name)) like ?)",
          string.downcase.tr("*", "%").tr("×", "x"),
          Name.string_for_possible_hybrids(string))
  end

  def self.string_for_possible_hybrids(string)
    string.downcase.tr("*", "%").sub(/^([^x])/, 'x \1').tr("×", "x")
  end

  # Setting up the final few associations got tricky.
  def self.unordered_accepted_tree_synonyms
    Name.joins(:cited_by_instance_tree_arrangements)
        .joins(:cited_by_instance_tree_node_names)
        .joins("inner join name_tree_path ntp
                on cited_by_instance_tree_node_names_name.id = ntp.name_id")
        .joins(" inner join tree_arrangement ntp_ta
                on ntp.tree_id = ntp_ta.id and ntp_ta.label = 'APC' ")
        .includes(:status)
        .includes(:cited_by_instance_tree_node_names)
        .joins(:rank)
        .joins(:name_type)
  end

  def self.new_unordered_accepted_tree_synonyms
    Name.joins(:rank)
        .joins(:cited_by_names)
        .joins(:apc_tree_arrangements)
        .joins(:name_type)
        .includes(:status)
  end

  def self.scientific_search
    Name.not_a_duplicate
        .has_an_instance
        .includes(:status)
        .includes(:rank)
  end

  def self.cultivar_search
    Name.not_a_duplicate
        .has_an_instance
        .includes(:status)
        .joins(:rank)
  end

  def self.common_search
    Name.not_a_duplicate
        .has_an_instance
        .includes(:status)
        .order("sort_name")
  end

  def family_name
    name_tree_path_default.rank_path.sub(/.*Familia:/, "").sub(/>.*$/, "")
  end

  def apc_instance_id
    # TreeNode.apc(full_name).try("first").try("instance_id")
    AcceptedName.where(id: id).try("first").try("instance_id")
  end

  def direct_sub_taxa_with_instance_count
    Name.where(parent_id: id).joins(:instances).select("distinct name.id").count
  end

  def show_status?
    status.show?
  end

  def as_json(options = {})
    logger.debug("as_json options: #{options}")
    [name: full_name, status: status.name]
  end

  def to_csv
    attributes.values_at(*Name.columns.map(&:name))
    [full_name, status.name].to_csv
  end

  def self.csv_headings
    %w(full_name status).to_csv
  end

  def apc_accepted?
    apc_accepted_instance.present?
  end

  def apc_excluded?
    apc_excluded_instance.present?
  end

  def apc_comment
    return unless apc_accepted?
    apc_accepted_instance.apc_comment
  end

  def apc_distribution
    return unless apc_accepted?
    apc_accepted_instance.apc_distribution
  end

  # For compatibility with name_instance_vw.
  def status_name
    status.name
  end

  def author_component_of_full_name
    full_name.sub(/#{Regexp.escape(simple_name)}/, "")
  end
end
