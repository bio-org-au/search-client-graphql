# frozen_string_literal: true

# Container for names in results
class TaxonomyController::Results::Taxon::Synonyms < Array
  def initialize(synonyms_open_struct)
    @synonyms = synonyms_open_struct
    build unless @synonyms.nil?
  end

  def build
    @synonyms.each do |raw_synonym|
      self.push(Synonym.new(raw_synonym))
    end
  end
end
