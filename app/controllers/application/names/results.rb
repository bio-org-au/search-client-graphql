# frozen_string_literal: true

# Container for search results
class Application::Names::Results
  def initialize(search_result)
    @search_result = search_result
    @data = search_result.try('data').try('filteredNames').try('data')
    @paginator_info = build_paginator_info(search_result.try('data').try('filteredNames').try('paginatorInfo'))
  end

  def build_paginator_info(paginatorInfo)
    pinfo = OpenStruct.new
    return if paginatorInfo.nil?

    pinfo.count = paginatorInfo.count
    pinfo.current_page  = paginatorInfo.currentPage
    pinfo.has_more_pages  = paginatorInfo.hasMorePages
    pinfo.first_item = paginatorInfo.firstItem
    pinfo.last_item = paginatorInfo.lastItem
    pinfo.last_page = paginatorInfo.lastPage
    pinfo.per_page = paginatorInfo.perPage
    pinfo.total  = paginatorInfo.total
    pinfo
  end

  def data
    @data
  end

  def paginator_info
    @paginator_info
  end

  def empty?
    throw 'empty'
    @data.nil?
  end

  def no_data?
    throw 'no data'
    @search_result.data.nil? || @search_result.data.name.nil?
  end

  def error?
    @search_result.errors.present? || @search_result.data.error.present?
  end

  def error
    if @search_result.errors.present?
      @search_result.errors.first.message
    else
      @search_result.data.error
    end
  end

  def no_search?
    throw 'no_search'
    @search_result.data.name_search.nil?
  end

  def no_names?
    throw 'no_names'
    @search_result.data.name_search.names.blank?
  end

  def xpresent?
    !(@search_result.nil? ||
      @search_result.data.nil? ||
      @search_result.data.name_search.nil? ||
      @search_result.data.name_search.names.blank?)
  end

  def present?
    true
  end

  def blank?
    throw 'blank?'
    @search_result.nil? ||
      @search_result.data.nil? ||
      @search_result.data.name_search.nil? ||
      @search_result.data.name_search.names.blank?
  end

  def size
    if present?
      @data.size
    else
      0
    end
  end

  def count
    throw 'count'
    @paginator_info.count
  rescue
    'Error'
  end

  def names
    return nil if error?

    @data.collect do |name|
      Application::Names::Results::Name.new(name)
    end
  end
end
