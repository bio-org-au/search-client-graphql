module ApniHelper
  def display_instance(instance, shown)
    if instance.standalone?
      display = show_standalone_instance(instance)
    else
      display, shown = show_relationship_instance(instance, shown)
    end
    [display, shown]
  end

  def show_standalone_instance(instance)
    fragment = instance.reference.citation_html
    fragment << ": #{instance.page}" if instance.page.present?
    fragment << "<ul>"
    Instance.records_cited_by_standalone(instance).each do |cited_by|
      fragment << "<li/>"
      fragment << "#{cited_by.instance_type.name}: " \
                  "#{cited_by.name.full_name_html}"
    end
    fragment << "</ul>"
    fragment.html_safe
  end

  def show_relationship_instance(instance, shown)
    citing_instance = instance.this_is_cited_by
    return "", shown if shown.include?(citing_instance.id)
    shown.push(citing_instance.id)
    fragment = instance.reference.citation_html
    fragment << assemble_cited_by(instance, citing_instance)
    [fragment.html_safe, shown]
  end

  def assemble_cited_by(instance, citing_instance)
    fragment = "<ul>"
    Instance.records_cited_by_relationship(citing_instance).each do |cited_by|
      next unless cited_by.name.id == instance.name.id
      fragment << "<li/>"
      fragment << "#{cited_by.instance_type.name}: " \
                  "#{cited_by.name.full_name_html}"
    end
    fragment << "</ul>"
  end
end
