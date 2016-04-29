drop view name_or_synonym_vw;

create view name_or_synonym_vw as
select 0 id,
       cast('' as varchar) simple_name,
       cast('' as varchar) full_name,
       cast('' as varchar) type_code,
       0 instance_id,
       0 tree_node_id,
       0 accepted_id,
       cast('' as varchar) accepted_full_name,
       0 name_status_id,
       0 reference_id,
       0 name_rank_id,
       cast('' as varchar) sort_name
  from name where 1 = 0

