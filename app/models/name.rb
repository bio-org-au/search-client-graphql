#  Name object methods
class Name < ActiveRecord::Base
  self.table_name = "name"
  self.primary_key = "id"
  acts_as_tree
  belongs_to :rank, class_name: "NameRank", foreign_key: "name_rank_id"
  belongs_to :status, class_name: "NameStatus", foreign_key: "name_status_id"
  belongs_to :name_type
  has_many :instances
  has_many :tree_nodes
  has_many :name_tree_paths

  has_many :apni_tree_arrangements, through: :apni_name_tree_paths
  has_many :apni_name_tree_paths, class_name: "NameTreePath"

  has_many :apc_tree_arrangements, through: :apc_tree_nodes
  has_many :apc_tree_nodes, -> { where "next_node_id is null and checked_in_at_id is not null"},
           class_name: "TreeNode"


  scope :not_a_duplicate, -> { where(duplicate_of_id: nil) }
  scope :has_an_instance, -> { where(["exists (select null from instance where name.id = instance.name_id)"]) }
  scope :lower_full_name_like, ->(string) { where("lower(f_unaccent(full_name)) like lower(f_unaccent(?)) ", string.gsub(/\*/, "%").downcase) }
  scope :lower_simple_name_like, ->(string) { where("lower((simple_name)) like lower((?)) ", string.gsub(/\*/, "%").downcase) }

  def instances_in_order
    self.instances.sort do |x, y|
      x.sort_fields <=> y.sort_fields
    end
  end

  def self.scientific_search
    Name.not_a_duplicate
        .has_an_instance
        .includes(:status)
        .includes(:rank)
        .joins(:apni_tree_arrangements)
        .order('name_tree_path.rank_path, name.full_name')
  end

  def self.common_search
    Name.not_a_duplicate
        .has_an_instance
        .includes(:status)
        .order('name.full_name')
  end

  def self.accepted_tree_search
    Name.includes(:status)
        .includes(:rank)
        .joins(:apc_tree_arrangements)
        .joins(:name_tree_paths)
        .where(" name_tree_path.tree_id = tree_arrangement.id")
        .order("name_tree_path.rank_path")
  end

  def self.accepted_tree_accepted_search
    Name.accepted_tree_search
        .where(" tree_node.type_uri_id_part = 'ApcConcept'")
  end

  def self.accepted_tree_excluded_search
    Name.accepted_tree_search
        .where(" tree_node.type_uri_id_part = 'ApcExcluded'")
  end

  def self.accepted_tree_accepted_or_excluded_search
    Name.accepted_tree_search
        .where(" tree_node.type_uri_id_part in ('ApcExcluded', 'ApcConcept')")
  end

  def family?
    rank.family?
  end

  def family_name
    n = self
    Name.seek_family_name(n)
  end

  def self.seek_family_name(n)
    if n.blank?
      ""
    elsif n.family?
      n.full_name
    else
      n = n.parent
      Name.seek_family_name(n)
    end
  end

  def apc?
    TreeNode.apc?(full_name)
  end

  def apc_instance_id
    TreeNode.apc(full_name).try("first").try("instance_id")
  end

  def pg_descendants
    rid = id
    Name.join_recursive do
      start_with(id: rid)
        .connect_by(id: :parent_id)
        .order_siblings(:full_name)
        .nocycle
    end
  end

  # Built as pg-specific code (although should be standard sql)
  # Originally tried "tn.parent_id = #{id}" but this was slow
  # (~1200ms vs ~3ms) despite an index on parent_id.
  def pg_ranked_descendant_counts
    sql = "WITH RECURSIVE nodes_cte(id, full_name, parent_id, depth, path) AS (
 SELECT tn.id, tn.full_name, tn.parent_id, 1::INT AS depth,
        tn.id::TEXT AS path, tnr.name as rank, tnr.sort_order rank_order
   FROM name AS tn
        join
        name_rank tnr
        on tn.name_rank_id = tnr.id
  WHERE tn.id = #{ActiveRecord::Base.sanitize(id)}
UNION ALL
 SELECT c.id, c.full_name, c.parent_id, p.depth + 1 AS depth,
        (p.path || '->' || c.id::TEXT), cnr.name as rank,
        cnr.sort_order rank_order
   FROM nodes_cte AS p, name AS c
        join name_rank cnr
        on c.name_rank_id = cnr.id
  WHERE c.parent_id = p.id
)
 SELECT n.rank, count(*) FROM nodes_cte AS n
 where exists (select null from instance where instance.name_id = n.id)
   and n.id != #{ActiveRecord::Base.sanitize(id)}
  group by n.rank, n.rank_order
  order by n.rank_order"
  ActiveRecord::Base.connection.execute(sql)
  end

  def pg_descendants_at_rank(rank_name)
    sql = "WITH RECURSIVE nodes_cte(id, full_name, parent_id, depth, path) AS (
 SELECT tn.id, tn.full_name, tn.parent_id, 1::INT AS depth,
        tn.id::TEXT AS path, tnr.name as rank, tnr.sort_order rank_order
   FROM name AS tn
        join
        name_rank tnr
        on tn.name_rank_id = tnr.id
  WHERE tn.id = #{ActiveRecord::Base.sanitize(id)}
UNION ALL
 SELECT c.id, c.full_name, c.parent_id, p.depth + 1 AS depth,
        (p.path || '->' || c.id::TEXT),
        cnr.name as rank, cnr.sort_order rank_order
   FROM nodes_cte AS p, name AS c
        join name_rank cnr
        on c.name_rank_id = cnr.id
  WHERE c.parent_id = p.id
)
SELECT n.id, n.full_name FROM nodes_cte AS n
       inner join
       name_tree_path ntp
       on n.id = ntp.name_id
       inner join
       tree_arrangement ta
       on ta.id = ntp.tree_id
  where n.rank = #{ActiveRecord::Base.sanitize(rank_name)}
    and ta.label = 'APNI'
    and exists (select null from instance where instance.name_id = n.id)
  order by n.full_name"
  ActiveRecord::Base.connection.execute(sql)
  end

  def sub_taxon?
    sql = "WITH RECURSIVE nodes_cte(id, full_name, parent_id, depth, path) AS (
 SELECT tn.id, tn.full_name, tn.parent_id, 1::INT AS depth,
        tn.id::TEXT AS path, tnr.name as rank, tnr.sort_order rank_order
   FROM name AS tn
        join
        name_rank tnr
        on tn.name_rank_id = tnr.id
  WHERE tn.id = #{id}
UNION ALL
 SELECT c.id, c.full_name, c.parent_id, p.depth + 1 AS depth,
        (p.path || '->' || c.id::TEXT),
        cnr.name as rank, cnr.sort_order rank_order
   FROM nodes_cte AS p, name AS c
        join name_rank cnr
        on c.name_rank_id = cnr.id
  WHERE c.parent_id = p.id
)
SELECT 1 FROM nodes_cte AS n
  where exists (select null from instance where instance.name_id = n.id)
limit 3"
    results = ActiveRecord::Base.connection.execute(sql)
    max = 0
    results.each_with_index do |result, index|
      max = index
    end
    Rails.logger.debug("max: #{max}")
    if max <= 1
      return false
    else
      return true
    end
  end

  def pg_apni_descendants
    sql = "WITH RECURSIVE nodes_cte(id, full_name, parent_id, depth, path) AS (
 SELECT tn.id, tn.full_name, tn.parent_id, 1::INT AS depth,
        tn.id::TEXT AS path, tnr.name as rank, tnr.sort_order rank_order
   FROM name AS tn
        join
        name_rank tnr
        on tn.name_rank_id = tnr.id
  WHERE tn.id = #{ActiveRecord::Base.sanitize(id)}
UNION ALL
 SELECT c.id, c.full_name, c.parent_id, p.depth + 1 AS depth,
        (p.path || '->' || c.id::TEXT),
        cnr.name as rank, cnr.sort_order rank_order
   FROM nodes_cte AS p, name AS c
        join name_rank cnr
        on c.name_rank_id = cnr.id
  WHERE c.parent_id = p.id
)
 SELECT n.id, n.full_name
  FROM nodes_cte AS n
       inner join
       name_tree_path ntp
       on n.id = ntp.name_id
       inner join
       tree_arrangement ta
       on ta.id = ntp.tree_id
  where ta.label = 'APNI'
    and exists (select null from instance where instance.name_id = n.id)
    and n.id != #{ActiveRecord::Base.sanitize(id)}
  order by ntp.rank_path, n.full_name"
  ActiveRecord::Base.connection.execute(sql)
  end

  def pg_apni_descendants_for_ranks(ranks = " ('nothing') ")
    sql = "WITH RECURSIVE nodes_cte(id, full_name, parent_id, depth, path) AS (
 SELECT tn.id, tn.full_name, tn.parent_id, 1::INT AS depth,
        tn.id::TEXT AS path, tnr.name as rank, tnr.sort_order rank_order
   FROM name AS tn
        join
        name_rank tnr
        on tn.name_rank_id = tnr.id
  WHERE tn.id = #{ActiveRecord::Base.sanitize(id)}
UNION ALL
 SELECT c.id, c.full_name, c.parent_id, p.depth + 1 AS depth,
        (p.path || '->' || c.id::TEXT),
        cnr.name as rank, cnr.sort_order rank_order
   FROM nodes_cte AS p, name AS c
        join name_rank cnr
        on c.name_rank_id = cnr.id
  WHERE c.parent_id = p.id
)
SELECT n.id, n.full_name
  FROM nodes_cte AS n
       inner join
       name_tree_path ntp
       on n.id = ntp.name_id
       inner join
       tree_arrangement ta
       on ta.id = ntp.tree_id
  where ta.label = 'APNI'
    and exists (select null from instance where instance.name_id = n.id)
    and n.id != #{ActiveRecord::Base.sanitize(id)}
    and n.rank in " + ranks +
        "order by ntp.rank_path, n.full_name"
  ActiveRecord::Base.connection.execute(sql)
  end

  def show_status?
    status.show?
  end

  def as_json(options = {})
    case options[:show] 
    when :details
      [name: full_name, status: status.name]
    else
      [name: full_name, status: status.name]
    end
  end

  def to_csv
    attributes.values_at(*Name.columns.map(&:name))
    [full_name, status.name].to_csv
  end

  def self.csv_headings
    ["full_name", "status"].to_csv
  end

end
