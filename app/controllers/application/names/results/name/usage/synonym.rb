# frozen_string_literal: true

# Container for name usage synonyms in results
class Application::Names::Results::Name::Usage::Synonym
  attr_reader :raw_synonym
  LEFT_SQUARE_BRACKET = /^\[/
  LEGITIMATE = 'legitimate'
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
    return '' if @raw_synonym.name_status_name.match(LEFT_SQUARE_BRACKET)
    return '' if @raw_synonym.name_status_name == LEGITIMATE
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
end
