class Name < ActiveRecord::Base
  self.table_name = "name"
  self.primary_key = "id"
  acts_as_tree
  belongs_to :rank, class_name: "NameRank", foreign_key: "name_rank_id"
  belongs_to :name_type
  has_many :instances
  has_many :tree_nodes

  scope :not_a_duplicate, -> { where(duplicate_of_id: nil) }
  scope :with_an_instance, -> { where(["exists (select null from instance where name.id = instance.name_id)"]) }
  scope :lower_full_name_like, ->(string) { where("lower(f_unaccent(full_name)) like lower(f_unaccent(?)) ", string.gsub(/\*/, "%").downcase) }
  scope :lower_simple_name_like, ->(string) { where("lower((simple_name)) like lower((?)) ", string.gsub(/\*/, "%").downcase) }
 
  def instances_in_order
    self.instances.sort do |x,y|
      x.sort_fields <=> y.sort_fields
    end
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
    TreeNode.apc(full_name).try('first').try('instance_id')
  end

  def pg_descendants
    rid = self.id
    Name.join_recursive do
      start_with(id: rid)
      .connect_by(id: :parent_id)
      .order_siblings(:full_name)
      .nocycle
    end
  end

  def pg_ranked_descendant_counts
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
        (p.path || '->' || c.id::TEXT), cnr.name as rank, cnr.sort_order rank_order
   FROM nodes_cte AS p, name AS c
        join name_rank cnr
        on c.name_rank_id = cnr.id
  WHERE c.parent_id = p.id
)                                                                
SELECT n.rank, count(*) FROM nodes_cte AS n
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
  WHERE tn.id = #{id}
UNION ALL                   
 SELECT c.id, c.full_name, c.parent_id, p.depth + 1 AS depth,
        (p.path || '->' || c.id::TEXT), cnr.name as rank, cnr.sort_order rank_order
   FROM nodes_cte AS p, name AS c
        join name_rank cnr
        on c.name_rank_id = cnr.id
  WHERE c.parent_id = p.id
)                                                                
SELECT n.id, n.full_name FROM nodes_cte AS n
  where n.rank = '#{rank_name}'
  order by n.full_name"
  ActiveRecord::Base.connection.execute(sql)
  end

end
