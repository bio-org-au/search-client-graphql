# frozen_string_literal: true

# Advanced Names view helpers.
module AdvancedNamesHelper
   def page
    @results.paginator_info.current_page
  end

  def pages
    @results.paginator_info.last_page
  end

  def previous
    return 'prev' if @results.paginator_info.current_page == 1

    cparams = params.except!('action', 'controller')
    cparams[:page] = @results.paginator_info.current_page - 1
    link_to('prev', names_advanced_search_path(cparams), class: 'underline', title: 'Previous page')
  end

  def next_
    cparams = params.except!('action', 'controller')
    return 'next' unless @results.paginator_info.has_more_pages

    cparams[:page] = @results.paginator_info.current_page + 1
    link_to('next', names_advanced_search_path(cparams), class: 'underline', title: 'Next page')
  end

  def first_
    return 'first' if @results.paginator_info.current_page == 1

    cparams = params.except!('action', 'controller')
    cparams[:page] = 1
    link_to('first', names_advanced_search_path(cparams), class: 'underline', title: 'First page')
  end

  def last_
    cparams = params.except!('action', 'controller')
    return 'last' if @results.paginator_info.current_page == @results.paginator_info.last_page

    cparams[:page] = @results.paginator_info.last_page
    link_to('last', names_advanced_search_path(cparams), class: 'underline', title: 'Last page')
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
