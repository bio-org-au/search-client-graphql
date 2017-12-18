# frozen_string_literal: true

# Container for search results
class Application::Names::Results
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
    @search.errors.present?
  end

  def error
    @search.errors.first.message
  end

  def no_search?
    @search.data.name_search.nil?
  end

  def no_names?
    @search.data.name_search.names.blank?
  end

  def present?
    !(@search.nil? ||
      @search.data.nil? ||
      @search.data.name_search.nil? ||
      @search.data.name_search.names.blank?)
  end

  def blank?
    @search.nil? ||
      @search.data.nil? ||
      @search.data.name_search.nil? ||
      @search.data.name_search.names.blank?
  end

  def size
    if present?
      @search.data.name_search.names.size
    else
      0
    end
  end

  def count
    @search.data.name_search.count
  rescue
    "Error"
  end

  def names
    @search.data.name_search.names.collect do |name|
      Application::Names::Results::Name.new(name)
    end
  end
end
