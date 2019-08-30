# frozen_string_literal: true

# Class extracted from name controller.
class AdvancedNamesController::Index::NameSearchRequest::Utilities::Argument
  def types
    hash = {}
    hash[:searchTerm] = 'String'
    hash[:authorAbbrev] = 'String'
    hash[:exAuthorAbbrev] = 'String'
    hash[:baseAuthorAbbrev] = 'String'
    hash[:exBaseAuthorAbbrev] = 'String'
    hash[:family] = 'String'
    hash[:genus] = 'String'
    hash[:species] = 'String'
    hash[:rank] = 'String'
    hash[:includeRanksBelow] = 'Boolean'
    hash[:publication] = 'String'
    hash[:isoPublicationDate] = 'String'
    hash[:protologue] = 'Boolean'
    hash[:nameElement] = 'String'
    hash[:typeOfName] = 'String'
    hash[:scientificName] = 'Boolean'
    hash[:scientificAutonymName] = 'Boolean'
    hash[:scientificNamedHybridName] = 'Boolean'
    hash[:scientificHybridFormulaName] = 'Boolean'
    hash[:cultivarName] = 'Boolean'
    hash[:commonName] = 'Boolean'
    hash[:typeNoteText] = 'String'
    hash[:typeNoteKeys] = '[String!]'
    hash[:orderByName] = 'Boolean'
    hash
  end
end
