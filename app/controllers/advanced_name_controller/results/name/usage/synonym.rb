# frozen_string_literal: true

# Container for name usage synonyms in results
class AdvancedNameController::Results::Name::Usage::Synonym
  attr_reader :raw_synonym
  def initialize(raw_synonym)
    @raw_synonym = raw_synonym
  end

  def label
    @raw_synonym.label
  end

  def page
    @raw_synonym.page
  end

  def full_name
    @raw_synonym.full_name
  end
end
