# frozen_string_literal: true

# Container for name usages in results
class Application::Names::Results::Name::Usage
  attr_reader :raw_usage
  TREE_ACCEPTED = 'ApcConcept'
  TREE_EXCLUDED = 'ApcExcluded'

  def initialize(raw_usage)
    @raw_usage = raw_usage
  end

  def reference_usage
    rec = OpenStruct.new
    rec.instance_id = @raw_usage.reference_usage.instance_id
    rec.citation = @raw_usage.reference_usage.citation
    rec.page = @raw_usage.reference_usage.page
    rec.year = @raw_usage.reference_usage.year
    # rec.standalone = @raw_usage.standalone
    rec.instance_type_name = @raw_usage.reference_usage.instance_type_name
    rec.primary_instance = @raw_usage.reference_usage.primary_instance
    rec.reference_id = @raw_usage.reference_usage.reference_id
    rec.full_citation_with_page = "#{@raw_usage.reference_usage.citation}: #{@raw_usage.reference_usage.page || '-'} #{'[' + @raw_usage.reference_usage.instance_type_name + ']' if @raw_usage.primary_instance}"
    rec.accepted_tree_status = @raw_usage.reference_usage.accepted_tree_status
    rec.accepted_in_tree = @raw_usage.reference_usage.accepted_tree_status == TREE_ACCEPTED
    rec.excluded_from_tree = @raw_usage.reference_usage.accepted_tree_status == TREE_EXCLUDED
    rec
  end

  def misapplied?
    @raw_usage.misapplied
  end

  def citation_for_misapplied
    @raw_usage.citation
  end

  def misapplied_to_name
    @raw_usage.misapplied_to_name
  end

  def misapplied_to_id
    @raw_usage.misapplied_to_id
  end

  def misapplied_by_id
    @raw_usage.misapplied_by_id
  end

  def misapplied_by_citation
    @raw_usage.misapplied_by_citation
  end

  def misapplied_on_page
    @raw_usage.misapplied_on_page
  end

  def primary?
    @raw_usage.primary_instance
  end

  def misapplication_label
    @raw_usage.misapplication_label
  end

  def synonyms
    @raw_usage.synonyms.collect do |synonym|
      Application::Names::Results::Name::Usage::Synonym.new(synonym)
    end
  end

  def notes
    @raw_usage.notes
  end
end
