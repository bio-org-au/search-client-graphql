# frozen_string_literal: true

# Container for name usage synonyms in results
class Application::Names::Results::Name::Usage::Synonym
  attr_reader :raw_synonym
  ORTH_VAR = 'orth. var.'

  def initialize(raw_synonym)
    @raw_synonym = raw_synonym
  end

  def name_id
    @raw_synonym.name_id
  end

  def label
    @raw_synonym.label
  end

  def font_style
    # @raw_synonym.label == 'common name' ? '' : 'italics'
    ['common name', 'vernacular name'].include?(@raw_synonym.label) ? '' : 'italics'
  end

  def page
    @raw_synonym.page
  end

  # Return nil if not to be displayed.
  def name_status_name
    return '' if @raw_synonym.name_status_is_displayed == false
    return '' if @raw_synonym.name_status_name == ORTH_VAR &&
                 @raw_synonym.of_type_synonym
    @raw_synonym.name_status_name
  end

  def full_name
    @raw_synonym.full_name
  end

  def full_name_html
    @raw_synonym.full_name_html
  end

  def reference_citation
    @raw_synonym.reference_citation
  end

  def reference_page
    @raw_synonym.reference_page
  end

  def misapplied?
    @raw_synonym.misapplied == true
  end

  def misapplication_citation_details
    rec = OpenStruct.new
    return rec if @raw_synonym.misapplication_citation_details.blank?
    rec.in_reference_citation = @raw_synonym.misapplication_citation_details.misapplied_in_reference_citation
    rec.in_reference_citation_html = @raw_synonym.misapplication_citation_details.misapplied_in_reference_citation_html
    rec.in_reference_id = @raw_synonym.misapplication_citation_details.misapplied_in_reference_id
    rec.on_page = @raw_synonym.misapplication_citation_details.misapplied_on_page
    rec.on_page_qualifier = @raw_synonym.misapplication_citation_details.misapplied_on_page_qualifier
    rec.name_is_repeated = @raw_synonym.misapplication_citation_details.name_is_repeated
    rec
  end

  def mcd
    misapplication_citation_details
  end

  def year
    @raw_synonym.year
  end
end
