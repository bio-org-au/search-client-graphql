# frozen_string_literal: true

# Container for search results
class Application::Publications::Results
  def initialize(search)
    @search = search
  end

  def empty?
    @search.nil?
  end

  def no_data?
    @search.data.nil?
  end

  def no_search?
    @search.data.publication_search.nil?
  end

  def no_records?
    @search.data.publication_search.count == 0
  end

  def present?
    !(@search.nil? ||
      @search.data.nil? ||
      @search.data.publication_search.nil? ||
      @search.data.publication_search.publications.blank?)
  end

  def blank?
    @search.nil? ||
      @search.data.nil? ||
      @search.data.publication_search.nil? ||
      @search.data.publication_search.publications.blank?
  end

  def size
    if present?
      @search.data.publication_search.publications.size
    else
      0
    end
  end

  def count
    @search.data.publication_search.count
  end

  def publications
    @search.data.publication_search.publications.collect do |publication|
      Application::Publications::Results::Publication.new(publication)
    end
  end
end
