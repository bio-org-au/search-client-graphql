#  Other taxonomies
class Plants::Taxonomy::Other 

  TAXONOMIES = Rails.configuration.taxonomies
  DUMMY = { name: "dummy taxonomy",
            into: "This does not exist!",
          }

  def initialize(key)
    @key = key
    if TAXONOMIES.has_key?(key)
      @taxonomy = TAXONOMIES[key]
    else
      @taxonomy = DUMMY
    end
    @intro = @taxonomy[:intro]
  end

  def name
    @taxonomy[:name]
  end

  def intro
    @taxonomy[:intro]
  end

  def key
    @key
  end
end

