#  Name descendants object
class Plants::Names::Descendants 
  attr_reader :results,
              :sql,
              :size


  def initialize(id_string = '0')
    id = id_string.to_i
    @sql = "WITH RECURSIVE nodes_cte(id, full_name, parent_id, depth, path) AS (
    SELECT tn.id,
           tn.full_name,
           tn.parent_id,
           1::INT AS depth,
           tn.id::TEXT AS path
      FROM name AS tn
    WHERE tn.id = #{ActiveRecord::Base.sanitize(id)}
UNION ALL
    SELECT c.id,
           c.full_name,
           c.parent_id,
           p.depth + 1 AS depth,
           (p.path || '->' || c.id::TEXT)
      FROM nodes_cte AS p, name AS c
 WHERE c.parent_id      =  p.id
       )
SELECT name.full_name, name.sort_name, n.depth, n.path
  FROM nodes_cte AS n
  inner join name on n.id = name.id
 where exists (
    select null
      from instance
 where instance.name_id =  n.id
       )
    and n.id != #{ActiveRecord::Base.sanitize(id)}
 order by name.sort_name"
  @results = ActiveRecord::Base.connection.execute(@sql)
  # A difference between jRuby and Ruby
  if @results.class == Array
    @size = @results.size
  else
    @size = @results.values.size
  end
  end
end
