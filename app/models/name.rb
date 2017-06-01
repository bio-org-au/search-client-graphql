# frozen_string_literal: true
#  Name object methods
class Name < ActiveRecord::Base
  include NameSearchable
  include NameDisplayable
  include NameJsonable
  include NameCsvable
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

  def direct_sub_taxa_with_instance_count
    Name.where(parent_id: id).joins(:instances).select("distinct name.id").count
  end

  def citation
    if status.show?
      "#{full_name_html}#{status.name_to_show}"
    else
      full_name_html
    end
  end

  def image_count
    unless (Rails.cache.read("images")).class == Hash
      Names::Services::Images.load
    end
    Rails.cache.read("images")[simple_name]
  rescue => e
    logger.error("Error in Name#image_count: #{e.to_s}")
    logger.error("Assuming image_count is 0")
    0
  end

  def images_supported?
    Rails.configuration.try("image_links_supported") || false
  end

  def images_present?
    (image_count || 0) > 0
  end
end
