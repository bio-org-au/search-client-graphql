module ApniHelper
  def display_instance(instance, shown, check_apc = false)
    if instance.standalone?
      display = show_standalone_instance(instance, check_apc)
    else
      display, shown = show_relationship_instance(instance, shown)
    end
    [display, shown]
  end

  def show_standalone_instance(instance, apc)
    fragment = "<div class='instance-citation'>#{instance.reference.citation_html}"
    fragment << ": #{instance.page}" if instance.page.present?
    fragment << "&nbsp;<span class='red'>(APC)</span>" if apc 
    fragment << "</div>"
    fragment << "<ul>"
    Instance.records_cited_by_standalone(instance).each do |cited_by|
      fragment << "<li class='subordinate-instance'/>"
      fragment << "<span class='instance-type-name'>#{cited_by.instance_type.name}: </span>" \
        "<span class='instance-type'>#{link_to(cited_by.name.full_name, plants_names_show_path(cited_by.name.id))}</span>"
    end
    fragment << "</ul>"
    fragment.html_safe
  end

  def show_relationship_instance(instance, shown)
    citing_instance = instance.this_is_cited_by
    return "", shown if shown.include?(citing_instance.id)
    shown.push(citing_instance.id)
    fragment = "<div class='instance-citation'>#{instance.reference.citation_html}</div>"
    fragment << assemble_cited_by(instance, citing_instance)
    [fragment.html_safe, shown]
  end

  def assemble_cited_by(instance, citing_instance)
    fragment = "<ul>"
    Instance.records_cited_by_relationship(citing_instance).each do |cited_by|
      next unless cited_by.name.id == instance.name.id
      fragment << "<li class='subordinate-instance'/>"
      fragment << "<span class='instance-type-name'>#{cited_by.instance_type.name} of: </span>" \
        "<span class='instance-type'>#{link_to(cited_by.this_is_cited_by.name.full_name, plants_names_show_path(cited_by.this_is_cited_by.name.id))}</span>"
    end
    fragment << "</ul>"
  end
end
