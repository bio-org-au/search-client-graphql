# frozen_string_literal: true

# Container for name check results
class NameCheckController::Results
  def initialize(search_results)
    @search = search_results
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
    @search.data.name_check.nil?
  end

  def no_names?
    @search.data.name_check.results.blank?
  end

  def present?
    !(@search.nil? ||
      @search.data.nil? ||
      @search.data.name_check.nil? ||
      @search.data.name_check.results.blank?)
  end

  def blank?
    @search.nil? ||
      @search.data.nil? ||
      @search.data.name_check.nil? ||
      @search.data.name_check.results.blank?
  end

  def size
    if present?
      @search.data.name_check.results.size
    else
      0
    end
  end

  def count
    @search.data.name_check.count
  rescue
    'Error'
  end

  def results
    return nil if @search.nil?
    @search.data.name_check.results.collect do |checked_name|
      CheckedName.new(checked_name)
    end
  end
end

