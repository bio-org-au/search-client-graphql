drop view name_instance_vw;

create view name_instance_vw as
select n.id, n.full_name,n.simple_name,s.name status_name, r.name rank_name,
       r.visible_in_name rank_visible_in_name, 
       r.sort_order rank_sort_order,
       t.name type_name,
       t.scientific type_scientific,
       t.cultivar type_cultivar,
       i.id instance_id,
       ref.year reference_year,
       ref.citation_html reference_citation_html,
       ity.name instance_type_name,
       ity.primary_instance,
       ity.standalone instance_standalone,
       sty.standalone synonym_standalone,
       sty.name synonym_type_name,
       i.page,
       i.page_qualifier,
       case ity.primary_instance
      when true then 'A'
      else 'B'
      end primary_instance_first,
       sname.full_name synonym_full_name,
       n.sort_name
  from name n
       join name_status s on n.name_status_id = s.id
       join name_rank r on n.name_rank_id = r.id
       join name_type t on n.name_type_id = t.id
       join instance i on n.id = i.name_id
       join reference ref on i.reference_id = ref.id
       join instance_type ity on i.instance_type_id = ity.id
       left outer join instance syn on syn.cited_by_id = i.id
       left outer join instance_type sty on syn.instance_type_id = sty.id
       left outer join name sname on syn.name_id = sname.id
 where n.duplicate_of_id is null
;
