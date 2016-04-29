drop view accepted_name_vw;


create view accepted_name_vw as
select accepted.id,
       accepted.simple_name,
       accepted.full_name,
       tree_node.type_uri_id_part type_code,
       instance.id instance_id,
       tree_node.id tree_node_id,
       0 accepted_id,
       cast('' as varchar) accepted_full_name,
       accepted.name_status_id,
       instance.reference_id,
       accepted.name_rank_id,
       accepted.sort_name
  from name accepted
       inner join instance
       on accepted.id = instance.name_id
       inner join tree_node
       on accepted.id = tree_node.name_id
       inner join
       tree_arrangement ta
       on tree_node.tree_arrangement_id = ta.id
 where ta.label = 'APC'
   and tree_node.next_node_id is null
   and tree_node.checked_in_at_id is not null
   and instance.id = tree_node.instance_id

