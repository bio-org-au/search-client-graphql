# frozen_string_literal: true

# Container for taxon synonyms in results
class TaxonomyController::Results::Taxon::Synonyms::Synonym
  def initialize(raw_synonym)
    @raw_synonym = raw_synonym
  end

  def id
    @raw_synonym.id
  end

  def name_id
    @raw_synonym.name_id
  end

  def page
    @raw_synonym.page
  end

  def full_name
    @raw_synonym.full_name
  end

  def full_name_html
    @raw_synonym.full_name_html
  end

  def simple_name
    @raw_synonym.simple_name
  end

  def name_status
    @raw_synonym.name_status
  end

  def doubtful?
    @raw_synonym.is_doubtful
  end

  def misapplied?
    @raw_synonym.is_misapplied
  end

  def pro_parte?
    @raw_synonym.is_pro_parte
  end

  def page_qualifier
    @raw_synonym.page_qualifier
  end

  def misapplication
    Misapplication.new(@raw_synonym.misapplication_details)
  end
end
