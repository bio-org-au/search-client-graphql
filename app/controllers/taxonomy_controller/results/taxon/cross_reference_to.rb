# frozen_string_literal: true

# Container for taxon synonyms in results
class TaxonomyController::Results::Taxon::CrossReferenceTo
  def initialize(raw_cross_reference_to)
    @raw_cross_reference_to = raw_cross_reference_to
  end

  def full_name
    @raw_cross_reference_to.full_name
  end

  def full_name_html
    @raw_cross_reference_to.full_name_html
  end

  def misapplication?
    @raw_cross_reference_to.is_misapplication
  end

  def as_misapplication
    TaxonomyController::Results::Taxon::CrossReferenceTo::AsMisapplication.new(@raw_cross_reference_to.as_misapplication)
  end

  def pro_parte?
    @raw_cross_reference_to.is_pro_parte
  end

  def doubtful?
    @raw_cross_reference_to.is_doubtful
  end
end
