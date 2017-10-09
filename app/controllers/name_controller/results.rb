# frozen_string_literal: true

# Container for search results
class NameController::Results
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

  def names
    @search.data.name_search.names.collect do |name|
      NameController::Results::Name.new(name)
    end
  end
end
