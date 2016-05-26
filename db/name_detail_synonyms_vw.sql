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
       name.full_name,
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

;

grant select on name_detail_synonyms_vw to web;


