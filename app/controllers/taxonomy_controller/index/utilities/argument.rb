# frozen_string_literal: true

# Declare argument types for the graphql request.
class TaxonomyController::Index::Utilities::Argument
  def types
    hash = {}
    hash[:search_term] = 'String!'
    hash[:accepted_name] = 'Boolean'
    hash[:excluded_name] = 'Boolean'
    hash[:cross_reference] = 'Boolean'
    hash
  end
end
