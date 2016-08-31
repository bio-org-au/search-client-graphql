# frozen_string_literal: true
# Extracted from Name.
# Complex native postgres query has its own class.
class Names::Search::Within::RankedDescendantCounts
  attr_reader :results, :size, :executed_query, :clean_id

  SQL1 = "WITH RECURSIVE nodes_cte(id, full_name, parent_id, depth, path) AS (
 SELECT tn.id, tn.full_name, tn.parent_id, 1::INT AS depth,
        tn.id::TEXT AS path, tnr.name as rank, tnr.sort_order rank_order
   FROM name AS tn
        join
        name_rank tnr
        on tn.name_rank_id = tnr.id
  WHERE tn.id = "

  SQL2 = " UNION ALL
 SELECT c.id, c.full_name, c.parent_id, p.depth + 1 AS depth,
        (p.path || '->' || c.id::TEXT), cnr.name as rank,
        cnr.sort_order rank_order
   FROM nodes_cte AS p, name AS c
        join name_rank cnr
        on c.name_rank_id = cnr.id
  WHERE c.parent_id = p.id
)"

  SQL3 = " SELECT n.rank, count(*) FROM nodes_cte AS n
 where exists (select null from instance where instance.name_id = n.id)
   and n.id != "

  SQL4 = " group by n.rank, n.rank_order
  order by n.rank_order"

  def initialize(id)
    @clean_id = ActiveRecord::Base.sanitize(id)
    @executed_query = execute_query
    @results = executed_query.to_a
    @size = executed_query.ntuples
    @status = executed_query.cmd_status
  end

  # Built as pg-specific code (although should be standard sql)
  # Originally tried "tn.parent_id = #{id}" but this was slow
  # (~1200ms vs ~3ms) despite an index on parent_id.
  def execute_query
    sql = "#{SQL1} #{@clean_id} #{SQL2} #{SQL3} #{@clean_id} #{SQL4}"
    ActiveRecord::Base.connection.execute(sql)
  end
end
