# frozen_string_literal: true

# Container for taxon synonyms in results
class TaxonomyController::Results::Taxon::CrossReferenceTo::AsMisapplication
  def initialize(raw_as_misapp)
    @raw_as_misapp = raw_as_misapp
  end

  def citing_instance_id
    @raw_as_misapp.citing_instance_id
  end

  def citing_reference_id
    @raw_as_misapp.citing_reference_id
  end

  def citing_reference_author_string_and_year
    return nil if @raw_as_misapp.nil?
    @raw_as_misapp.citing_reference_author_string_and_year
  end

  def misapplying_author_string_and_year
    @raw_as_misapp.misapplying_author_string_and_year
  end

  def name_author_string
    @raw_as_misapp.name_author_string
  end

  def cited_simple_name
    @raw_as_misapp.cited_simple_name
  end

  def cited_page
    @raw_as_misapp.cited_page
  end
end
