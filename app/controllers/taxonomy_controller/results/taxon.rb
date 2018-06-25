# frozen_string_literal: true

# Container for names in results
class TaxonomyController::Results::Taxon
  def initialize(raw_taxon)
    @raw_taxon = raw_taxon
  end

  def simple_name
    @raw_taxon.simple_name
  end

  def full_name
    @raw_taxon.full_name
  end

  def full_name_html
    @raw_taxon.full_name_html
  end

  def name_status_name
    return nil if @raw_taxon.name_status_name.nil? ||
                  @raw_taxon.name_status_is_displayed == false
    @raw_taxon.name_status_name
  end

  def name_status_display?
    @raw_taxon.name_status_is_displayed
  end

  def usages
    @raw_taxon.name_history.name_usages.collect do |usage|
      SearchController::Results::Name::Usage.new(usage)
    end
  end

  def family_name
    @raw_taxon.family_name
  end

  def reference_citation
    @raw_taxon.reference_citation
  end

  def id
    @raw_taxon.id
  end

  def record_type
    'excluded-name' #@raw_taxon.record_type
  end

  def cross_reference?
    @raw_taxon.is_cross_reference
  end

  def cross_referenced_full_name_id
    @raw_taxon.cross_referenced_full_name_id
  end

  def excluded?
    @raw_taxon.is_excluded
  end

  def taxon_comment?
    !taxon_comment.blank?
  end

  def taxon_comment
    @raw_taxon.taxon_comment
  end

  def taxon_distribution?
    !taxon_distribution.blank?
  end

  def taxon_distribution
    @raw_taxon.taxon_distribution
  end

  def misapplication?
    @raw_taxon.is_misapplication == true
  end

  def xpro_parte?
    @raw_taxon.is_pro_parte == true
  end

  def synonyms
    TaxonomyController::Results::Taxon::Synonyms.new(@raw_taxon.synonyms)
  end

  def cross_reference_to
    TaxonomyController::Results::Taxon::CrossReferenceTo.new(@raw_taxon.cross_reference_to)
  end

  def order_string
    @raw_taxon.order_string
  end

  def source_object
    @raw_taxon.source_object
  end
end
