# frozen_string_literal: true

# Starting with a name-reference, prepare a collection of instances,
# comments and notes ready to be displayed.
class NameReferenceInstanceSet
  attr_reader :results, :name_references, :images, :name, :names_within
  def initialize(name_id)
    @name = Name.find(name_id)
    @name_references =
      Name.where(id: name_id)
          .joins(instances: :instance_type)
          .joins(references: :author)
          .select("name.id name_id,name.full_name, name.full_name_html, \
    reference.id reference_id,instance_type.id,author.id, \
    reference.citation_html,coalesce(reference.year,9999), author.name,  \
    primary_instance")
          .group("name.id, name.full_name, reference.id,instance_type.id, \
    author.id,reference.citation_html,coalesce(reference.year,9999),  \
    author.name, primary_instance")
          .order("coalesce(reference.year,9999), primary_instance desc,  \
    author.name")
    build_results
    build_names_within
  end

  def build_names_within
    @names_within = !Name.where(parent_id: @name.id).empty?
  end

  def build_results
    @results = @name_references.collect { |nr| template(nr) }.uniq
    add_standalones
    add_protologue
    add_accepted_or_excluded
    add_relationships
    add_cited_by
    add_misapplications
    add_common_names
    add_instance_notes
    add_type_notes
    add_page_no
    add_primary_instance
    add_images
  end

  def add_standalones
    @results.each do |result|
      Instance.where(name_id: result[:name_id],
                     reference_id: result[:reference_id],
                     cited_by_id: nil, cites_id: nil).each do |instance|
        result[:standalone_instances].push(instance.id)
      end
    end
  end

  def add_protologue
    @results.each do |result|
      result[:standalone_instances].each do |standalone_instance|
        instance = Instance.find(standalone_instance)
        if instance.has_protologue?
          result[:protologue] = {source_id: instance.source_id}
        end
      end
    end
  end

  def add_accepted_or_excluded
    @results.each do |result|
      result[:standalone_instances].each do |standalone_instance|
        accepted_or_excluded = AcceptedOrExcluded
                               .where(id: result[:name_id],
                                      instance_id: standalone_instance)
        accepted_or_excluded.each do |aoe|
          result[:accepted_name] = true if aoe.accepted?
          result[:excluded_name] = true if aoe.excluded?
          result[:declared_bt] = true if aoe.declared_bt?
        end
      end
    end
  end

  def add_relationships
    @results.each do |result|
      Instance.where(name_id: result[:name_id],
                     reference_id: result[:reference_id])
              .where("cited_by_id is not null").each do |instance|
        next if instance.instance_type.misapplied?
        result[:relationship_instances]
          .push(instance_id: instance.id,
                cites_id: instance.cites_id,
                cited_by_id: instance.cited_by_id,
                instance_type: instance.instance_type.of_label,
                name_id: instance.this_is_cited_by.name.id,
                name_citation: instance.this_is_cited_by.name.citation,
                page: instance.this_is_cited_by.page,)
      end
    end
  end

  def add_misapplications
    @results.each do |result|
      Instance.where(name_id: result[:name_id],
                     reference_id: result[:reference_id])
              .where("cited_by_id is not null").each do |instance|
        next unless instance.instance_type.misapplied?
        misapplied_by = "by #{instance.this_cites.reference.citation_html}"
        unless instance.this_cites.page.blank?
          misapplied_by += ": #{instance.this_cites.page}"
        end
        result[:misapplications]
          .push(instance_type: instance.instance_type.of_label,
                name_id: instance.this_is_cited_by.name.id,
                name_citation: instance.this_is_cited_by.name.citation,
                misapplied_by: misapplied_by)
      end
    end
  end

  def add_common_names
    @results.each do |result|
      result[:standalone_instances].each do |standalone|
        result[:common_names] =
          Instance.find(standalone)
                  .synonyms_for_display_just_commons
                  .sort { |x, y| x.name.simple_name <=> y.name.simple_name }
                  .collect do |common|
                    { name_id: common.name_id,
                      name_citation: common.name.citation }
                  end
      end
    end
  end

  def add_cited_by
    @results.each do |result|
      result[:standalone_instances].each do |standalone|
        result[:cited_by] =
          Instance.where(cited_by_id: standalone)
                  .joins(:instance_type, :name, :reference)
                  .where("instance_type.name not in ('common name',
        'vernacular name')")
                  .sort do |x, y|
                    [x.instance_type.sort_order,
                     (x.this_cites.reference.year || 9999),
                     x.name.full_name.downcase] \
                     <=> \
                      [y.instance_type.sort_order,
                       (y.this_cites.reference.year || 9999),
                       y.name.full_name.downcase]
                  end
                  .collect do |cited_by|
                    {
                      instance_type: cited_by.instance_type.has_label,
                      name_id: cited_by.name.id,
                      name_citation: cited_by.name.citation,
                      reference_year: cited_by.this_cites.reference.year,
                      page: cited_by.page,
                    }
                  end
      end
    end
  end

  def add_type_notes
    @results.each do |result|
      result[:standalone_instances].each do |standalone|
        result[:type_notes] =
          Instance.find(standalone)
                  .instance_notes
                  .where(" instance_note.instance_note_key_id in
        (select id from instance_note_key where name in ('Type','Lectotype','Neotype'))")
                  .collect do |note|
            { key_name: note.instance_note_key.name,
              note_value: note.value }
          end
      end
    end
  end

  def add_instance_notes
    @results.each do |result|
      result[:standalone_instances].each do |standalone|
        result[:instance_notes] =
          Instance.find(standalone)
                  .instance_notes
                  .where(" instance_note.instance_note_key_id not in
        (select id from instance_note_key where name in ('Type','Lectotype','Neotype'))")
                  .collect do |note|
                    { key_name: note.instance_note_key.name,
                      note_value: note.value }
                  end
      end
    end
  end

  def add_page_no
    @results.each do |result|
      result[:page_rule] = "no rule"
      if result[:standalone_instances].size == 1 && result[:relationship_instances].empty? && result[:cited_by].empty?
        instance = Instance.find(result[:standalone_instances].first)
        result[:page] = instance.page
        result[:page] ||= '-'
        #result[:standalone_instances].first[:page_shown_above] = true
        result[:page_rule] = "page from singl standalone instance"
      elsif result[:standalone_instances].empty? && result[:relationship_instances].size == 1 && result[:cited_by].empty?
        result[:page] = result[:relationship_instances].first[:page]
        result[:page] ||= '-'
        result[:relationship_instances].first[:page_shown_above] = true
        result[:page_rule] = "page from singl relationship instance"
      elsif result[:standalone_instances].empty? && result[:relationship_instances].empty? && result[:cited_by].size == 1
        result[:page] = result[:cited_by].first[:page]
        result[:page] ||= '-'
        result[:cited_by].first[:page_shown_above] = true
        result[:page_rule] = "page from single cited_by instance"
      else
        result[:page_rule] = "multiple instances"
      end
      next unless result[:page].nil? &&
                  result[:relationship_instances].size == 1
      result[:page] = Instance.find(result[:relationship_instances]
                              .first[:instance_id])
                              .page
    end
  end

  def add_primary_instance
    @results.each do |result|
      result[:standalone_instances].each do |standalone|
        instance = Instance.find(standalone)
        if instance.primary?
          result[:primary_instance] = true if Instance.find(standalone).primary?
          result[:instance_type_name] = instance.instance_type.name
        end
      end
    end
  end

  def add_images
    name = Name.find(@results.first[:name_id])
    if name.images_supported? && name.rank.species_or_below? && name.images_present?
      @images = { simple_name: name.simple_name, count: name.image_count }
    else
      @images = nil
    end
  end

  def template(nr)
    ActiveSupport::HashWithIndifferentAccess.new(
      sequence: nil,
      treat_as_new_reference: true,
      name_id: nr.name_id,
      full_name: nr.full_name,
      name_citation: nr.full_name_html,
      reference_id: nr.reference_id,
      author_id: nil,
      citation_html: nr.citation_html,
      page: nil,
      type_notes: nil,
      instance_notes_count: 0,
      instance_notes: nil,
      common_names_count: 0,
      common_names: [],
      cited_by_count: 0,
      cited_by: [],
      accepted_name: nil,
      excluded_name: nil,
      declared_bt: nil,
      standalone_instances: [],
      relationship_instances: [],
      misapplications: [],
      protologue: nil,
      images: nil,
      has_names_within: true,
    )
  end
end
