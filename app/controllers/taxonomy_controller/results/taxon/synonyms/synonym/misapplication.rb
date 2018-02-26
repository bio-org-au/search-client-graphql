# frozen_string_literal: true

# Container for taxon synonyms in results
class TaxonomyController::Results::Taxon::Synonyms::Synonym::Misapplication
  def initialize(raw_misapp)
    @raw_misapp = raw_misapp
  end

  def name_author_string
    @raw_misapp.name_author_string
  end

  def cites_simple_name
    @raw_misapp.cites_simple_name
  end

  def cites_reference_citation
    @raw_misapp.cites_reference_citation
  end

  def cites_reference_citation_html
    @raw_misapp.cites_reference_citation_html
  end

  def page
    @raw_misapp.page
  end
end
