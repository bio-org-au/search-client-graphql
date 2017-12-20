# frozen_string_literal: true

# Pagination view helpers.
module PaginationHelper
  def pagination_debug
    "Offset: #{@client_request.offset} , limit: #{@client_request.limit} , total: #{@results.count} "
  end

  def page
    (@client_request.offset/@client_request.limit) + 1
  end

  def pages
    (@results.count.to_f/@client_request.limit).ceil
  end

  def previous
    return if @client_request.offset == 0
    cparams = params.except!('action','controller')
    cparams[:offset] = (@client_request.offset - @client_request.limit) 
    link_to('Prev', names_advanced_search_path(cparams), title: 'Previous page')
  end

  def next_
    cparams = params.except!('action','controller')
    cparams[:offset] = (@client_request.offset + @client_request.limit) 
    return if cparams[:offset].to_i > @results.count
    link_to('Next', names_advanced_search_path(cparams), title: 'Next page')
  end

  def first_
    return if @client_request.offset == 0
    cparams = params.except!('action','controller')
    cparams[:offset] = 0
    link_to('First', names_advanced_search_path(cparams), title: 'First page')
  end

  def last_
    cparams = params.except!('action','controller')
    cparams[:offset] = (@results.count/@client_request.limit) * @client_request.limit
    return if @client_request.offset == cparams[:offset]
    link_to('Last', names_advanced_search_path(cparams), title: 'First page')
  end
end
