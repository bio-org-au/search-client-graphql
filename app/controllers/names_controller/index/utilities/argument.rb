# frozen_string_literal: true

# Class extracted from name controller.
class NamesController::Index::Utilities::Argument
  def types
    hash = {}
    hash[:search_term] = 'String'
    hash['author_abbrev'] = 'String'
    hash['ex_author_abbrev'] = 'String'
    hash['base_author_abbrev'] = 'String'
    hash['ex_baseAuthor_abbrev'] = 'String'
    hash['family'] = 'String'
    hash['genus'] = 'String'
    hash['species'] = 'String'
    hash['rank'] = 'String'
    hash['include_ranks_below'] = 'Boolean'
    hash['publication'] = 'String'
    hash['iso_publication_date'] = 'String'
    hash['protologue'] = 'String'
    hash['name_element'] = 'String'
    hash['type_of_name'] = 'String'
    hash[:scientific_name] = 'Boolean'
    hash['scientific_autonym_name'] = 'Boolean'
    hash['scientific_named_hybrid_name'] = 'Boolean'
    hash['scientific_hybrid_formula_name'] = 'Boolean'
    hash[:cultivar_name] = 'Boolean'
    hash[:common_name] = 'Boolean'
    hash['type_note_text'] = 'String'
    hash['type_note_keys'] = '[String]'
    hash['order_by_name'] = 'Boolean'
    hash
  end
end
