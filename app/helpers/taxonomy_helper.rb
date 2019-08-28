# frozen_string_literal: true

# Pagination view helpers.
module TaxonomyHelper
  def pagination_debug
    "Offset: #{@client_request.offset} , limit: #{@client_request.limit} , total: #{@results.count} "
  end

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
    link_to('prev', taxonomy_search_path(cparams), class: 'underline', title: 'Previous page')
  end

  def next_
    cparams = params.except!('action', 'controller')
    return 'next' unless @results.paginator_info.has_more_pages

    cparams[:page] = @results.paginator_info.current_page + 1
    link_to('next', taxonomy_search_path(cparams), class: 'underline', title: 'Next page')
  end

  def first_
    return 'first' if @results.paginator_info.current_page == 1

    cparams = params.except!('action', 'controller')
    cparams[:page] = 1
    link_to('first', taxonomy_search_path(cparams), class: 'underline', title: 'First page')
  end

  def last_
    cparams = params.except!('action', 'controller')
    return 'last' if @results.paginator_info.current_page == @results.paginator_info.last_page

    cparams[:page] = @results.paginator_info.last_page
    link_to('last', taxonomy_search_path(cparams), class: 'underline', title: 'Last page')
  end

  def xprevious
    return if @client_request.offset == 0
    cparams = params.except!('action', 'controller')
    cparams[:offset] = (@client_request.offset - @client_request.limit)
    link_to('Prev', taxonomy_search_path(cparams), title: 'Previous page')
  end

  def xnext_
    cparams = params.except!('action', 'controller')
    cparams[:offset] = (@client_request.offset + @client_request.limit)
    return if cparams[:offset].to_i > @results.count
    link_to('Next', taxonomy_search_path(cparams), title: 'Next page')
  end

  def xfirst_
    return if @client_request.offset == 0
    cparams = params.except!('action', 'controller')
    cparams[:offset] = 0
    link_to('First', taxonomy_search_path(cparams), title: 'First page')
  end

  def xlast_
    cparams = params.except!('action', 'controller')
    cparams[:offset] = (@results.count / clean_limit) * @client_request.limit
    return if @client_request.offset == cparams[:offset]
    link_to('Last', taxonomy_search_path(cparams), title: 'First page')
  end

  def clean_limit
    [@client_request.limit, 1].max
  end

  def accepted_name_cb_hover_text
    "When checked, accepted names will be displayed in the results of the next list search."
  end

  def excluded_name_cb_hover_text
    "When checked, excluded names will be displayed in the results of the next list search."
  end

  def cross_references_cb_hover_text
    "When checked, cross references will be displayed in the results of the next list search."
  end

  def show_distribution_hover_text
    "When checked, distribution will be shown for taxa in the results of the next search."
  end

  def show_comments_hover_text
    "When checked, comments will be shown for taxa in the results of the next search."
  end

  def show_synonyms_hover_text
    "When checked, synonyms will be shown for taxa in the results of the next search."
  end

  def name_and_status_for_display(full_name_html, name_status, name_status_is_displayed)
    if name_status_is_displayed
      %(#{full_name_html}, <span class="name-status">#{name_status}</span>)
    else
      full_name_html
    end
  end

  def string_with_hybrid_symbol(str)
    return '' if str.blank?
    str.gsub(/ x /,' × ')
  end

  def my_path
    Rails.application.config.action_controller.relative_url_root
  end

  def accepted_name_list_url(search_term, option_index = 0)
    "#{my_path}/taxonomy/search?utf8=✓&q=#{search_term}&accepted_names=1&list_or_count=list&limit_per_page_for_list=50&sample_search_option_index=#{option_index}"
  end

  def cross_reference_name_list_url(search_term, option_index = 0)
    "#{my_path}/taxonomy/search?utf8=✓&q=#{search_term}&cross_references=1&list_or_count=list&limit_per_page_for_list=50&sample_search_option_index=#{option_index}"
  end

  def cross_reference_name_list_with_links_url(search_term, option_index = 0)
    "#{my_path}/taxonomy/search?utf8=✓&q=#{search_term}&cross_references=1&list_or_count=list&limit_per_page_for_list=50&show_links=1&sample_search_option_index=#{option_index}"
  end

  def accepted_and_excluded_name_list_with_links_url(search_term, option_index = 0)
    "#{my_path}/taxonomy/search?utf8=✓&q=#{search_term}&accepted_names=1&excluded_names=1&list_or_count=list&show_links=1&limit_per_page_for_list=50&sample_search_option_index=#{option_index}"
  end

  def accepted_name_list_with_comments_url(search_term, option_index = 0)
    "#{my_path}/taxonomy/search?utf8=✓&q=#{search_term}&accepted_names=1&list_or_count=list&show_comments=1&limit_per_page_for_list=50&sample_search_option_index=#{option_index}"
  end

  def accepted_name_list_with_distribution_url(search_term, option_index = 0)
    "#{my_path}/taxonomy/search?utf8=✓&q=#{search_term}&accepted_names=1&list_or_count=list&show_distribution=1&limit_per_page_for_list=50&sample_search_option_index=#{option_index}"
  end

  def accepted_name_list_with_comments_distribution_url(search_term, option_index = 0)
    "#{my_path}/taxonomy/search?utf8=✓&q=#{search_term}&accepted_names=1&list_or_count=list&show_distribution=1&show_comments=1&limit_per_page_for_list=50&sample_search_option_index=#{option_index}"
  end

  def accepted_name_list_with_comments_url(search_term, option_index = 0)
    "#{my_path}/taxonomy/search?utf8=✓&q=#{search_term}&accepted_names=1&list_or_count=list&show_comments=1&limit_per_page_for_list=50&sample_search_option_index=#{option_index}"
  end

  def accepted_name_list_with_synonyms_url(search_term, option_index = 0)
    "#{my_path}/taxonomy/search?utf8=✓&q=#{search_term}&accepted_names=1&list_or_count=list&limit_per_page_for_list=50&show_synonyms=1&sample_search_option_index=#{option_index}"
  end

  def accepted_name_list_with_links_synonyms_url(search_term, option_index = 0)
    "#{my_path}/taxonomy/search?utf8=✓&q=#{search_term}&accepted_names=1&list_or_count=list&limit_per_page_for_list=50&show_links=1&show_synonyms=1&sample_search_option_index=#{option_index}"
  end

  def accepted_name_list_with_links_synonyms_comments_url(search_term, option_index = 0)
    "#{my_path}/taxonomy/search?utf8=✓&q=#{search_term}&accepted_names=1&list_or_count=list&limit_per_page_for_list=50&show_comments=1&show_links=1&show_synonyms=1&sample_search_option_index=#{option_index}"
  end

  def accepted_name_list_with_links_synonyms_comments_distribution_url(search_term, option_index = 0)
    "#{my_path}/taxonomy/search?utf8=✓&q=#{search_term}&accepted_names=1&list_or_count=list&limit_per_page_for_list=50&show_distribution=1&show_comments=1&show_links=1&show_synonyms=1&sample_search_option_index=#{option_index}"
  end

  def accepted_excluded_name_list_with_comments_url(search_term, option_index = 0)
    "#{my_path}/taxonomy/search?utf8=✓&q=#{search_term}&accepted_names=1&excluded_names=1&list_or_count=list&show_comments=1&limit_per_page_for_list=50&sample_search_option_index=#{option_index}"
  end

  def accepted_excluded_name_list_with_distribution_url(search_term, option_index = 0)
    "#{my_path}/taxonomy/search?utf8=✓&q=#{search_term}&accepted_names=1&excluded_names=1&list_or_count=list&show_distribution=1&limit_per_page_for_list=50&sample_search_option_index=#{option_index}"
  end

  def accepted_excluded_name_list_with_comments_distribution_url(search_term, option_index = 0)
    "#{my_path}/taxonomy/search?utf8=✓&q=#{search_term}&accepted_names=1&excluded_names=1&list_or_count=list&show_distribution=1&show_comments=1&limit_per_page_for_list=50&sample_search_option_index=#{option_index}"
  end

end

