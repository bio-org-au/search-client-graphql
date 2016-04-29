drop view accepted_synonym_vw;


create or replace view accepted_synonym_vw as
select name_as_syn.id,
       name_as_syn.simple_name simple_name,
       name_as_syn.full_name full_name,
       cast('synonym' as varchar) type_code,
       citer.id instance_id,
       tree_node.id tree_node_id,
       citer_name.id accepted_id,
       citer_name.full_name accepted_full_name,
       name_as_syn.name_status_id,
       0 reference_id,
       name_as_syn.name_rank_id,
       name_as_syn.sort_name
  from name name_as_syn
       inner join
       instance cites
       on name_as_syn.id = cites.name_id
       inner join
       reference cites_ref
       on cites.reference_id = cites_ref.id
       inner join
       instance citer
       on cites.cited_by_id = citer.id
       inner join
       reference citer_ref
       on citer.reference_id = citer_ref.id
       inner join
       name citer_name
       on citer.name_id = citer_name.id
       inner join
       tree_node
       on citer_name.id = tree_node.name_id
       inner join
       tree_arrangement ta
       on tree_node.tree_arrangement_id = ta.id
 where ta.label = 'APC'
   and tree_node.next_node_id is null
   and tree_node.checked_in_at_id is not null
   and tree_node.instance_id = citer.id

