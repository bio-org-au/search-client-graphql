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
    os.misapplied_to_full_name = @raw_usage.misapplication_details.misapplied_to_full_name
    os.misapplied_to_name_id = @raw_usage.misapplication_details.misapplied_to_name_id
    os.misapplied_in_reference_citation = @raw_usage.misapplication_details.misapplied_in_reference_citation
    os.misapplied_in_reference_id = @raw_usage.misapplication_details.misapplied_in_reference_id
    os.misapplied_on_page = @raw_usage.misapplication_details.misapplied_on_page
    os.misapplied_on_page_qualifier = @raw_usage.misapplication_details.misapplied_on_page_qualifier
    os.misapplication_type_label = @raw_usage.misapplication_details.misapplication_type_label
    os.misapplied_in_references = []
    @raw_usage.misapplication_details.misapplied_in_references.each do |in_ref|
      iros = OpenStruct.new
      iros.citation = in_ref.citation
      iros.id = in_ref.id
      iros.page = in_ref.page
      iros.page_qualifier = in_ref.page_qualifier
      iros.misapplication_type_label = in_ref.misapplication_type_label
      os.misapplied_in_references.push(iros)
    end
    os
  end

  def synonyms
    @raw_usage.synonyms.collect do |synonym|
      Application::Names::Results::Name::Usage::Synonym.new(synonym)
    end
  end

  def accepted_tree_details?
    !@raw_usage.accepted_tree_details.blank?
  end

  def accepted_in_accepted_tree?
    !@raw_usage.accepted_tree_details.blank? && @raw_usage.accepted_tree_details.try('is_accepted')
  end

  def excluded_from_accepted_tree?
    !@raw_usage.accepted_tree_details.blank? && @raw_usage.accepted_tree_details.is_excluded
  end

  def accepted_tree_comment_label
    @raw_usage.accepted_tree_details.try('comment').try('key')
  end

  def accepted_tree_comment
    @raw_usage.accepted_tree_details.try('comment').try('value')
  end

  def accepted_tree_comment?
    !accepted_tree_comment.blank?
  end

  def accepted_tree_distribution_label
    @raw_usage.accepted_tree_details.try('distribution').try('key')
  end

  def accepted_tree_distribution
    @raw_usage.accepted_tree_details.try('distribution').try('value')
  end

  def accepted_tree_distribution?
    !accepted_tree_distribution.blank?
  end

  def notes
    @raw_usage.notes
  end

  def non_current_accepted_tree_details?
    !@raw_usage.non_current_accepted_tree_details.blank?
  end

  def non_current_accepted_tree_comment_label
    @raw_usage.non_current_accepted_tree_details.try('comment').try('key')
  end

  def non_current_accepted_tree_comment
    @raw_usage.non_current_accepted_tree_details.try('comment').try('value')
  end

  def non_current_accepted_tree_comment?
    !non_current_accepted_tree_comment.blank?
  end

  def non_current_accepted_tree_distribution_label
    @raw_usage.non_current_accepted_tree_details.try('distribution').try('key')
  end

  def non_current_accepted_tree_distribution
    @raw_usage.non_current_accepted_tree_details.try('distribution').try('value')
  end

  def non_current_accepted_tree_distribution?
    !non_current_accepted_tree_distribution.blank?
  end
  
end
