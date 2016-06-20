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
   and instance.id = tree_node.instance_id;

grant select on accepted_name_vw to web;


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
;

grant select on accepted_synonym_vw to web;

drop view name_details_vw;

create view name_details_vw as
select n.id,
       n.full_name,
       n.simple_name,
       s.name status_name,
       r.name rank_name,
       r.visible_in_name rank_visible_in_name,
       r.sort_order rank_sort_order,
       t.name type_name,
       t.scientific type_scientific,
       t.cultivar type_cultivar,
       i.id instance_id,
       ref.year reference_year,
       ref.id reference_id,
       ref.citation_html reference_citation_html,
       ity.name instance_type_name,
       ity.id instance_type_id,
       ity.primary_instance,
       ity.standalone instance_standalone,
       sty.standalone synonym_standalone,
       sty.name synonym_type_name,
       i.page,
       i.page_qualifier,
       i.cited_by_id,
       i.cites_id,
       i.bhl_url,
       case ity.primary_instance
      when true then 'A'
      else 'B'
      end primary_instance_first,
       sname.full_name synonym_full_name,
       author.name author_name,
       n.id name_id,
       n.sort_name,
       ref.citation_html||': '|| coalesce(i.page,'') ||
       case ity.primary_instance
       when true then
         ' ['||ity.name||']'
       else
        ''
       end entry
  from name n
       join name_status s on n.name_status_id = s.id
       join name_rank r on n.name_rank_id = r.id
       join name_type t on n.name_type_id = t.id
       join instance i on n.id = i.name_id
       join instance_type ity on i.instance_type_id = ity.id
       join reference ref on i.reference_id = ref.id
       left outer join author on ref.author_id = author.id
       left outer join instance syn on syn.cited_by_id = i.id
       left outer join instance_type sty on syn.instance_type_id = sty.id
       left outer join name sname on syn.name_id = sname.id
 where n.duplicate_of_id is null
;

grant select on name_details_vw to web;




drop view name_detail_synonyms_vw;

create view name_detail_synonyms_vw as
select cited_by_id,
       ity.name||':'||name.full_name_html||
       case when nom_illeg or nom_inval then
         ns.name
       else ''
       end entry,
       instance.id,
       instance.cites_id,
       ity.name instance_type_name,
       ity.sort_order instance_type_sort_order,
       name.full_name,
       name.full_name_html,
       ns.name,
       instance.name_id name_id,
       instance.id instance_id,
       instance.cited_by_id name_detail_id,
       instance.reference_id
  from instance
 inner join name
    on instance.name_id = name.id
 inner join instance_type ity
    on ity.id      = instance.instance_type_id
 inner join name_status ns
    on ns.id = name.name_status_id
 where ity.name not in ('common name', 'vernacular name')

;

grant select on name_detail_synonyms_vw to web;

drop view name_detail_commons_vw;

create view name_detail_commons_vw as
select cited_by_id,
       ity.name||':'||name.full_name_html||
       case when nom_illeg or nom_inval then
         ns.name
       else ''
       end entry,
       instance.id,
       instance.cites_id,
       ity.name instance_type_name,
       ity.sort_order instance_type_sort_order,
       name.full_name,
       name.full_name_html,
       ns.name,
       instance.name_id name_id,
       instance.id instance_id,
       instance.cited_by_id name_detail_id
  from instance
 inner join name
    on instance.name_id = name.id
 inner join instance_type ity
    on ity.id      = instance.instance_type_id
 inner join name_status ns
    on ns.id = name.name_status_id
 where ity.name in ('common name', 'vernacular name')

;

grant select on name_detail_commons_vw to web;



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
  from name where 1 = 0;


grant select on name_or_synonym_vw to web;


