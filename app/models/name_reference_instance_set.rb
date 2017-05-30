# frozen_string_literal: true

# Starting with a name-reference, prepare a collection of instances,
# comments and notes ready to be displayed.
class NameReferenceInstanceSet
 
  attr_reader :results
  def initialize(name_references)
    @name_references = name_references
    build_results
  end

  def sorted_references
    @name_references.sort {|x,y| (x.reference.year || 9999) <=> (y.reference.year || 9999)}
  end

  def build_results
    stage_1
    @results.uniq!
    collapse_misapplieds
  end

  def stage_1
    @results = []
    sorted_references.each do |name_reference|
      instances = name_reference.instances
      instance_count = instances.size
      misapplied_count = 0
      non_misapplied_count = 0
      instances.each do |i|
        if i.instance_type.misapplied?
          misapplied_count += 1
        else
          non_misapplied_count += 1
        end
      end
      if instance_count == 1 && name_reference.instances.first.page.present?
        show_page = true
        page = name_reference.instances.first.page
      else
        show_page = false
        page = nil
      end
      name_reference.instances.sort {|x,y| (x.instance_type.misapplied? ? 'Z' : 'A') <=> (y.instance_type.misapplied? ? 'Z' : 'A') }.each_with_index do |instance, index|
        if misapplied_count == 1 || non_misapplied_count == 1
          show_page = true
          page = instance.page
        end
        if instance.standalone?
          relationship_name_id = ""
          relationship_name_citation = ""
          cited_by = Instance
            .records_cited_by_standalone_excluding_commons(instance)
            .collect do |cited_by|
              {
                instance_type: cited_by.instance_type.has_label,
                name_id: cited_by.name.id,
                name_citation: cited_by.name.citation,
              }
          end
        else
          relationship_name_id = instance.this_is_cited_by.name.id
          relationship_name_citation = instance.this_is_cited_by.name.citation
          cited_by = []
        end  
        if instance.instance_type.misapplied?
          misapplied = true
          show_instance = true
          misapplied_by = "by #{instance.this_cites.reference.citation_html}"
          misapplied_by += ": #{instance.this_cites.page}" unless instance.this_cites.page.blank?
          misapplied_by = misapplied_by.html_safe
        else
          misapplied = false
          show_instance = false
          misapplied_by = ""
        end
        accepted_or_excluded = AcceptedOrExcluded.where(id: name_reference.name_id, instance_id: instance.id)
        unless accepted_or_excluded.empty?
          accepted_name = accepted_or_excluded.first.accepted?
          excluded_name = accepted_or_excluded.first.excluded?
          declared_bt = accepted_or_excluded.first.declared_bt?
        else
          accepted_name = excluded_name = declared_bt = false
        end
        if instance.instance_type.relationship? && !instance.instance_type.misapplied?
          @results.push(
                        ActiveSupport::HashWithIndifferentAccess.new(
                          sequence: index + 1,
                          treat_as_new_reference: true,
                          name_id: name_reference.name_id,
                          full_name: instance.this_is_cited_by.name.full_name,
                          name_citation: instance.name.citation,
                          reference_id: name_reference.reference_id,
                          author_id: name_reference.author_id,
                          citation_html: instance.reference.citation_html,
                          instance_id: instance.id,
                          instance_type_id: instance.instance_type.id,
                          instance_type_name: instance.instance_type.name,
                          instance_count: instance_count,
                          primary_instance: false,
                          relationship_name_id: relationship_name_id,
                          relationship_name_citation: relationship_name_citation,
                          show_page: show_page,
                          page: page,
                          show_instance: true,
                          standalone: instance.standalone?,
                          instance_type_label: instance.instance_type.of_label,
                          misapplied: false,
                          misapplied_by: misapplied ? misapplied_by : "",
                          instance_notes_count: 0,
                          instance_notes: [],
                          common_names_count: 0,
                          common_names: [],
                          cited_by_count: 0,
                          cited_by: [],
                          accepted_name: accepted_name,
                          excluded_name: excluded_name,
                          declared_bt: declared_bt,
                        )
          )
        else
          @results.push(
                      ActiveSupport::HashWithIndifferentAccess.new(
                        sequence: index + 1,
                        treat_as_new_reference: true,
                        name_id: name_reference.name_id,
                        full_name: instance.name.full_name,
                        name_citation: instance.name.citation,
                        reference_id: name_reference.reference_id,
                        author_id: name_reference.author_id,
                        citation_html: name_reference.citation_html,
                        instance_id: instance.id,
                        instance_type_id: instance.instance_type.id,
                        instance_type_name: instance.instance_type.name,
                        instance_count: instance_count,
                        primary_instance: name_reference.primary_instance,
                        relationship_name_id: relationship_name_id,
                        relationship_name_citation: relationship_name_citation,
                        show_page: show_page,
                        page: page,
                        show_instance: show_instance,
                        standalone: instance.standalone?,
                        instance_type_label: instance.instance_type.of_label,
                        misapplied: misapplied,
                        misapplied_by: misapplied ? misapplied_by : "",
                        instance_notes_count: instance.instance_notes.size,
                        instance_notes: instance.instance_notes.collect {|note| {key_name: note.instance_note_key.name, note_value: note.value} },
                        common_names_count: instance.synonyms_for_display_just_commons.size,
                        common_names: instance.synonyms_for_display_just_commons.sort {|x,y| x.name.simple_name <=> y.name.simple_name}.collect {|common| {name_id: common.name_id, name_citation: common.name.citation} },
                        cited_by_count: cited_by.count,
                        cited_by: cited_by,
                        accepted_name: accepted_name,
                        excluded_name: excluded_name,
                        declared_bt: declared_bt,
                      )
          )
        end
      end
    end
  end

  def collapse_misapplieds
    previous = {}
    @results.each do |element|
      element[:treat_as_new_reference] = false if element[:sequence] > 1 && element[:instance_type_name] == "misapplied" && previous[:instance_type_name] == "misapplied"
      previous = element
    end
  end
end

