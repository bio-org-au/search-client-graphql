# frozen_string_literal: true

# Container for taxonomy results
class TaxonomyController::Results
  def initialize(search)
    @search = search
  end

  def empty?
    @search.nil?
  end

  def no_data?
    @search.data.nil?
  end

  def error?
    @search.errors.present? || @search.data.error.present?
  end

  def error
    if @search.errors.present?
      @search.errors.first.message
    else
      @search.data.error
    end
  end

  def no_search?
    @search.data.taxonomy_search.nil?
  end

  def no_names?
    @search.data.taxonomy_search.taxa.blank?
  end

  def present?
    !(@search.nil? ||
      @search.data.nil? ||
      @search.data.taxonomy_search.nil? ||
      @search.data.taxonomy_search.taxa.blank?)
  end

  def blank?
    @search.nil? ||
      @search.data.nil? ||
      @search.data.taxonomy_search.nil? ||
      @search.data.taxonomy_search.taxa.blank?
  end

  def size
    if present?
      @search.data.taxonomy_search.taxa.size
    else
      0
    end
  end

  def count
    @search.data.taxonomy_search.count
  rescue
    'Error'
  end

  def taxa
    @search.data.taxonomy_search.taxa.collect do |taxon|
      TaxonomyController::Results::Taxon.new(taxon)
    end
  end
end
