# frozen_string_literal: true

# Container for name usages in results
class Application::Names::Results::Name::Usage
  attr_reader :raw_usage
  TREE_ACCEPTED = 'ApcConcept'
  TREE_EXCLUDED = 'ApcExcluded'

  def initialize(raw_usage)
    @raw_usage = raw_usage
  end

  def reference_details
    rec = OpenStruct.new
    rec.id = @raw_usage.reference_details.id
    rec.citation = @raw_usage.reference_details.citation
    rec.page = @raw_usage.reference_details.page
    rec.page_qualifier = @raw_usage.reference_details.page_qualifier
    rec.year = @raw_usage.reference_details.year
    rec.full_citation_with_page = "#{@raw_usage.reference_details.citation}: #{@raw_usage.reference_details.page || '-'} #{'[' + @raw_usage.instance_type_name + ']' if @raw_usage.primary_instance}"
    rec.full_citation_with_page_html = "#{@raw_usage.reference_details.citation_html}: #{@raw_usage.reference_details.page || '-'} #{'[' + @raw_usage.instance_type_name + ']' if @raw_usage.primary_instance}"
    rec
  end


  def old_rd
    rec.instance_id = @raw_usage.reference_usage.instance_id
    rec.citation = @raw_usage.reference_usage.citation
    rec.page = @raw_usage.reference_usage.page
    rec.year = @raw_usage.reference_usage.year
    # rec.standalone = @raw_usage.standalone
    rec.instance_type_name = @raw_usage.reference_usage.instance_type_name
    rec.primary_instance = @raw_usage.reference_usage.primary_instance
    rec.reference_id = @raw_usage.reference_usage.reference_id
    rec.accepted_tree_status = @raw_usage.reference_usage.accepted_tree_status
    rec
  end

  def accepted_in_tree
    @raw_usage.accepted_tree_status == TREE_ACCEPTED
  end

  def excluded_from_tree
    @raw_usage.accepted_tree_status == TREE_EXCLUDED
  end

  def misapplied?
    !@raw_usage.misapplication_details.blank?
  end

  def xcitation_for_misapplied
    @raw_usage.citation
  end

  def xmisapplied_to_name
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

  def xmisapplication_details
    @raw_usage.misapplication_details
  end

  def misapplication_details
    os = OpenStruct.new
    os.direction = '' #@raw_usage.misapplication_details.direction
    os.misapplied_to_full_name = @raw_usage.misapplication_details.first.misapplied_to_full_name
    os.misapplied_to_name_id = @raw_usage.misapplication_details.first.misapplied_to_name_id
    os.misapplied_in_reference_citation = @raw_usage.misapplication_details.first.misapplied_in_reference_citation
    os.misapplied_in_reference_id = @raw_usage.misapplication_details.first.misapplied_in_reference_id
    os.misapplied_on_page = @raw_usage.misapplication_details.first.misapplied_on_page
    os.misapplied_on_page_qualifier = @raw_usage.misapplication_details.first.misapplied_on_page_qualifier
    os.misapplication_type_label = @raw_usage.misapplication_details.first.misapplication_type_label
    os
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
