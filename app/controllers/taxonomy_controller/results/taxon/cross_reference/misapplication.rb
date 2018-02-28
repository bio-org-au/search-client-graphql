# frozen_string_literal: true

# Container for taxon synonyms in results
class TaxonomyController::Results::Taxon::CrossReference::Misapplication
  def initialize(raw_misapp)
    @raw_misapp = raw_misapp
  end

  def citing_instance_id
    @raw_misapp.citing_instance_id
  end

  def citing_reference_id
    @raw_misapp.citing_reference_id
  end

  def citing_reference_author_string_and_year
    return nil if @raw_misapp.nil?
    @raw_misapp.citing_reference_author_string_and_year
  end

  def misapplying_author_string_and_year
    return nil if @raw_misapp.nil?
    @raw_misapp.misapplying_author_string_and_year
  end

  def name_author_string
    @raw_misapp.name_author_string
  end

  def cites_simple_name
    @raw_misapp.cites_simple_name
  end

  def cites_page
    @raw_misapp.cites_page
  end

  def pro_parte?
    if @raw_misapp.nil?
      nil
    else
      @raw_misapp.pro_parte
    end
  end

  def doubtful?
    if @raw_misapp.nil?
      nil
    else
      @raw_misapp.is_doubtful
    end
  end
end
