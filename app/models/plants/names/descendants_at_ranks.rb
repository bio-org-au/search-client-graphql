#  Name descendants in a set of ranks object
class Plants::Names::DescendantsAtRanks 
  attr_reader :results,
              :sql,
              :size

  #def initialize(id_string = '0', rank_strings = [])
  def initialize(params)
    id = params[:id].to_i
    " ('Varietas') "
    @sql = "WITH RECURSIVE nodes_cte(id, full_name, parent_id, depth, path) AS (
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
    and n.rank in " + ranks_set(params) + 
        "order by ntp.rank_path, n.full_name"
  @results = ActiveRecord::Base.connection.execute(@sql)
  # A difference between jRuby and Ruby
  if @results.class == Array
    @size = @results.size
  else
    @size = @results.values.size
  end
  end

  def ranks_set(params)
    ranks = params.keys.collect {|k| "'#{k}'"}.join(',')
    ranks.sub!(/'unranked'/,"'[unranked]'")
    ranks.sub!(/'infrafamily'/,"'[infrafamily]'")
    ranks.sub!(/'infragenus'/,"'[infragenus]'")
    ranks.sub!(/'infraspecies'/,"'[infraspecies]'")
    ranks.sub!(/'n\/a'/,"'[n/a]'")
    ranks.sub!(/'unknown'/,"'[unknown]'")
    "(#{ranks})"
  end
end
