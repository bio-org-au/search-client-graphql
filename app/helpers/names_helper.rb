# frozen_string_literal: true

# Pagination view helpers.
module NamesHelper
  def pagination_debug
    "Offset: #{@client_request.offset} , limit: #{@client_request.limit} , total: #{@results.count} "
  end

  def page
    (@client_request.offset / [@client_request.limit, 1].max) + 1
  end

  def pages
    (@results.count.to_f / clean_limit).ceil
  end

  def previous
    return if @client_request.offset == 0
    cparams = params.except!('action', 'controller')
    cparams[:offset] = (@client_request.offset - @client_request.limit)
    link_to('Prev', name_search_path(cparams), title: 'Previous page')
  end

  def next_
    cparams = params.except!('action', 'controller')
    cparams[:offset] = (@client_request.offset + @client_request.limit)
    return if cparams[:offset].to_i > @results.count
    link_to('Next', name_search_path(cparams), title: 'Next page')
  end

  def first_
    return if @client_request.offset == 0
    cparams = params.except!('action', 'controller')
    cparams[:offset] = 0
    link_to('First', name_search_path(cparams), title: 'First page')
  end

  def last_
    cparams = params.except!('action', 'controller')
    cparams[:offset] = (@results.count / clean_limit) * @client_request.limit
    return if @client_request.offset == cparams[:offset]
    link_to('Last', name_search_path(cparams), title: 'First page')
  end

  def clean_limit
    [@client_request.limit, 1].max
  end
end