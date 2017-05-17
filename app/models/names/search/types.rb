# frozen_string_literal: true

#  Name search types
#
#  These are not the same as name types,
#  although they are related.
class Names::Search::Types
  SCIENTIFIC = "Scientific"
  CULTIVAR = "Cultivar"
  SCIENTIFIC_AND_CULTIVAR = "Scientific and Cultivar"
  COMMON = "Common"

  def all
    a = []
    a.push(SCIENTIFIC)
    a.push(CULTIVAR)
    a.push(SCIENTIFIC_AND_CULTIVAR)
    a.push(COMMON)
  end

  def all_except(exclusion)
    all.delete_if { |type| type.match(/\A#{exclusion}\z/i) }
  end
end
