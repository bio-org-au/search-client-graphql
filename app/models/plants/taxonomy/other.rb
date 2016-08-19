# frozen_string_literal: true
#  Other taxonomies
class Plants::Taxonomy::Other
  TAXONOMIES = Rails.configuration.taxonomies

  def initialize(key)
    @key = key
    if TAXONOMIES.key?(key)
      @taxonomy = TAXONOMIES[key]
      @intro = @taxonomy[:intro]
    else
      @taxonomy = nil
    end
  end

  def empty?
    @taxonomy.nil?
  end

  def name
    @taxonomy[:name] unless @taxonomy.nil?
  end

  def intro
    @taxonomy[:intro] unless @taxonomy.nil?
  end

  attr_reader :key
end
