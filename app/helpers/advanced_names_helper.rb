# frozen_string_literal: true

# Advanced Names view helpers.
module AdvancedNamesHelper
  def pagination_debug
    "Offset: #{@client_request.offset} , limit: #{@client_request.limit} , total: #{@results.count} "
  end

  def page
    (@client_request.offset / clean_limit) + 1
  end

  def pages
    (@results.count.to_f / clean_limit).ceil
  end

  def previous
    return if @client_request.offset == 0
    cparams = params.except!('action', 'controller')
    cparams[:offset] = (@client_request.offset - @client_request.limit)
    link_to('Prev', names_advanced_search_path(cparams), title: 'Previous page')
  end

  def next_
    cparams = params.except!('action', 'controller')
    cparams[:offset] = (@client_request.offset + @client_request.limit)
    return if cparams[:offset].to_i > @results.count
    link_to('Next', names_advanced_search_path(cparams), title: 'Next page')
  end

  def first_
    return if @client_request.offset == 0
    cparams = params.except!('action', 'controller')
    cparams[:offset] = 0
    link_to('First', names_advanced_search_path(cparams), title: 'First page')
  end

  def last_
    cparams = params.except!('action', 'controller')
    cparams[:offset] = (@results.count / clean_limit) * @client_request.limit
    return if @client_request.offset == cparams[:offset]
    link_to('Last', names_advanced_search_path(cparams), title: 'First page')
  end

  def clean_limit
    [@client_request.limit, 1].max
  end

  def my_path
    Rails.application.config.action_controller.relative_url_root
  end



  def advanced_list_common_name_url(search_term, option_index = 0)
    "#{my_path}/names/advanced?utf8=✓&q=#{search_term}&common_name=1&list_or_count=list&limit_per_page_for_list=50&limit_per_page_for_details=10&search=Search&sample_search_option_index=#{option_index}"
  end

  def advanced_list_common_name_with_links_url(search_term, option_index = 0)
    "#{my_path}/names/advanced?utf8=✓&q=#{search_term}&list_or_count=list&common_name=1&limit_per_page_for_list=50&limit_per_page_for_details=10&show_links=1&search=Search&sample_search_option_index=#{option_index}"
  end

  def advanced_list_common_name_with_details_url(search_term, option_index = 0)
    "#{my_path}/names/advanced?utf8=✓&q=#{search_term}&list_or_count=list&common_name=1&limit_per_page_for_list=50&limit_per_page_for_details=10&show_details=1&search=Search&sample_search_option_index=#{option_index}"
  end

  def advanced_list_common_name_with_links_and_details_url(search_term, option_index = 0)
    "#{my_path}/names/advanced?utf8=✓&q=#{search_term}&list_or_count=list&common_name=1&limit_per_page_for_list=50&limit_per_page_for_details=10&show_details=1&show_links=1&search=Search&sample_search_option_index=#{option_index}"
  end

  def advanced_list_common_cultivar_scientific_name_url(search_term, option_index = 0)
    "#{my_path}/names/advanced?utf8=✓&q=#{search_term}&common_name=1&cultivar_name=1&scientific_name=1&list_or_count=list&limit_per_page_for_list=50&limit_per_page_for_details=10&search=Search&sample_search_option_index=#{option_index}"
  end

  def advanced_list_common_cultivar_scientific_name_with_links_url(search_term, option_index = 0)
    "#{my_path}/names/advanced?utf8=✓&q=#{search_term}&list_or_count=list&common_name=1&cultivar_name=1&scientific_name=1&limit_per_page_for_list=50&limit_per_page_for_details=10&show_links=1&search=Search&sample_search_option_index=#{option_index}"
  end

  def advanced_list_common_cultivar_scientific_name_with_details_url(search_term, option_index = 0)
    "#{my_path}/names/advanced?utf8=✓&q=#{search_term}&list_or_count=list&common_name=1&cultivar_name=1&scientific_name=1&limit_per_page_for_list=50&limit_per_page_for_details=10&show_details=1&search=Search&sample_search_option_index=#{option_index}"
  end

  def advanced_list_common_cultivar_scientific_name_with_links_and_details_url(search_term, option_index = 0)
    "#{my_path}/names/advanced?utf8=✓&q=#{search_term}&list_or_count=list&common_name=1&cultivar_name=1&scientific_name=1&limit_per_page_for_list=50&limit_per_page_for_details=10&show_details=1&show_links=1&search=Search&sample_search_option_index=#{option_index}"
  end
end
