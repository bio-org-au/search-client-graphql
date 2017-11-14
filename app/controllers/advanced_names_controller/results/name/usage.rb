# frozen_string_literal: true

# Container for name usages in results
class AdvancedNamesController::Results::Name::Usage
  attr_reader :raw_usage

  def initialize(raw_usage)
    @raw_usage = raw_usage
    self
  end

  def misapplied?
    @raw_usage.misapplied
  end

  def citation_for_misapplied
    "#{@raw_usage.citation} [#{@raw_usage.instance_type_name}]"
  end

  def full_citation_with_page
    "#{@raw_usage.citation}: #{@raw_usage.page || '-'} #{'[' + @raw_usage.instance_type_name + ']' if @raw_usage.primary_instance}"
  end

  def misapplied_to_name
    @raw_usage.misapplied_to_name
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

  def instance_id
    @raw_usage.instance_id
  end

  def reference_id
    @raw_usage.reference_id
  end

  def instance_type_name
    @raw_usage.instance_type_name
  end

  def synonyms
    @raw_usage.synonyms.collect do |synonym|
      AdvancedNamesController::Results::Name::Usage::Synonym.new(synonym)
    end
  end

  def notes
    @raw_usage.notes
  end
end
