# frozen_string_literal: true

# Container for names in results
class TaxonomyController::Results::Taxon
  def initialize(raw_name)
    @raw_name = raw_name
  end

  def full_name
    @raw_name.full_name
  end

  def name_status_name
    return nil if @raw_name.name_status_name.nil? ||
                  @raw_name.name_status_name == 'legitimate' ||
                  @raw_name.name_status_name.match(/\[/)
    @raw_name.name_status_name
  end

  def usages
    @raw_name.name_history.name_usages.collect do |usage|
      SearchController::Results::Name::Usage.new(usage)
    end
  end

  def family_name
    @raw_name.family_name
  end

  def reference_citation
    @raw_name.reference_citation
  end

  def id
    @raw_name.id
  end

  def record_type
    @raw_name.record_type
  end

  def cross_reference?
    record_type == 'cross-reference'
  end

  def cross_referenced_full_name
    @raw_name.cross_referenced_full_name
  end

  def excluded?
    record_type == 'excluded-name'
  end

  def accepted_taxon_comment?
    !accepted_taxon_comment.blank?
  end

  def accepted_taxon_comment
    @raw_name.accepted_taxon_comment
  end

  def accepted_taxon_distribution?
    !accepted_taxon_distribution.blank?
  end

  def accepted_taxon_distribution
    @raw_name.accepted_taxon_distribution
  end
end
