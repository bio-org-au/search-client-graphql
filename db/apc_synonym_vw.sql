drop view apc_synonym_vw;

create or replace view apc_synonym_vw as
SELECT "name".id,
       name.full_name,
       name.simple_name,
       cited_by_name.full_name cited_by_name_full_name,
       instance.id instance_id,
       synonym_instance.id synonym_instance_id,
       synonym_instance.name_id synonym_instance_name_id,
       tree_node.type_uri_id_part,
       name_tree_path.rank_path
  FROM "name"
       inner join instance
       on name.id = instance.name_id
       inner join instance synonym_instance
       on instance.cited_by_id = synonym_instance.id
       inner join name cited_by_name
       on synonym_instance.name_id = cited_by_name.id
 INNER JOIN "tree_node"
    ON "tree_node"."instance_id" = "synonym_instance"."id"
   AND (
        next_node_id is null
   and checked_in_at_id is not null
       )
 INNER JOIN "tree_arrangement"
    ON "tree_arrangement"."id" = "tree_node"."tree_arrangement_id"
   AND "tree_arrangement"."label" = 'APC'
 INNER JOIN "name_tree_path"
    ON "name_tree_path"."name_id" = cited_by_name."id"
 INNER JOIN "name_type"
    ON "name_type"."id" = "name"."name_type_id"
 where ( name_tree_path.tree_id     = tree_arrangement.id)
;

