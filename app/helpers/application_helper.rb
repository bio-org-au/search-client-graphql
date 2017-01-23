# frozen_string_literal: true
# General view helpers.
module ApplicationHelper
  def new_target_id
    "#{rand(1000)}-#{rand(1000)}-#{rand(1000)}"
  end

  def ticked(s)
    "#{s} #{fa_icon('check')}".html_safe
  end

  def no_results_help(size)
    if size.zero?
      "<br/><br/>You may want to alter or reduce your search string,
      or add wildcards."
    else
      ""
    end
  end

  def nsl_path
    Rails.configuration.nsl_path
  end

  def flora_path
    Rails.configuration.flora_path
  end

  def fauna_path
    Rails.configuration.fauna_path
  end

  def shard
    ENV["SHARD"] || "shard"
  end

  def menu_label
    Rails.application.config.menu_label
  end

  def name_label
    Rails.application.config.name_label
  end

  def name_tree_label
    Rails.application.config.name_tree_label
  end

  def classification_tree_key
    Rails.application.config.classification_tree_key
  end

  def description_html
    Rails.application.config.description_html
  end

  def tree_description_html
    Rails.application.config.tree_description_html
  end

  def name_description_html
    Rails.application.config.name_description_html
  end

  def tree_banner_text
    Rails.application.config.tree_banner_text
  end

  def tree_label_text
    Rails.application.config.tree_label_text
  end

  def banner_text
    Rails.application.config.banner_text
  end

  def page_title
    Rails.application.config.page_title
  end

  def services_path_name_element
    Rails.application.config.services_path_name_element
  end

  def services_path_tree_element
    Rails.application.config.services_path_tree_element
  end

  def tree_search_help_text_html
    Rails.application.config.tree_search_help_text_html
  end

  def name_search_help_text_html
    Rails.application.config.name_search_help_text_html
  end

  def name_services(name_id)
    "#{Rails.configuration.services}#{Rails.configuration.services_path}\
/name/#{services_path_name_element}/#{name_id}"
  end

  def services_with_path
    "#{Rails.configuration.services}#{Rails.configuration.services_path}"
  end

  def name_link_title
    Rails.application.config.name_link_title
  end

  def tree_link_title
    Rails.application.config.tree_link_title
  end

  def menu_link_title
    Rails.application.config.menu_link_title
  end

  def name_label_text
    Rails.application.config.name_label_text
  end

  def name_banner_text
    Rails.application.config.name_banner_text
  end
end
