# frozen_string_literal: true
#  Name descendants object
class Names::Descendants
  attr_reader :results,
              :sql,
              :size

  SQL_1 = "WITH RECURSIVE nodes_cte(id, full_name, parent_id, depth, path) AS (
    SELECT tn.id,
           tn.full_name,
           tn.parent_id,
           1::INT AS depth,
           tn.id::TEXT AS path
      FROM name AS tn
    WHERE tn.id = "

  SQL_2 = "UNION ALL
    SELECT c.id,
           c.full_name,
           c.parent_id,
           p.depth + 1 AS depth,
           (p.path || '->' || c.id::TEXT)
      FROM nodes_cte AS p, name AS c
 WHERE c.parent_id      =  p.id
       )
SELECT n.id, name.full_name, name.sort_name, n.depth, n.path,
       nr.name rank
  FROM nodes_cte AS n
  inner join name on n.id = name.id
  inner join name_rank nr on nr.id = name.name_rank_id
 where exists (
    select null
      from instance
 where instance.name_id =  n.id
       )
    and n.id != "

  ORDER = "order by name.sort_name"

  def initialize(id_string = "0")
    @id = id_string.to_i
    sanitize
    build
    execute
    be_compatible
  end

  def sanitize
    @sanitized_id = ActiveRecord::Base.sanitize(@id)
  end

  def build
    @sql = "#{SQL_1} #{@sanitized_id}"
    @sql += "#{SQL_2} #{@sanitized_id} #{@ORDER}"
  end

  def execute
    @results = ActiveRecord::Base.connection.execute(@sql)
  end

  # A difference between jRuby and Ruby
  def be_compatible
    @size = if @results.class == Array
              @results.size
            else
              @results.values.size
            end
  end
end
