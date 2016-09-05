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

  def rect_with_text(text, color = "lightsteelblue", width = "500")
    %(<br><svg width="#{width}" height="100">
  <rect width="#{width}" height="100"
  style="fill:#{color};stroke-width:1;stroke:blue;" />
  <text x="50%" y="50%" text-anchor="middle" stroke="black"
  stroke-width="1px" dy=".3em" font-family="Verdana" font-size="18">
    #{text}
  </text>
</svg>)
  end

  def shard
    ENV["SHARD"] || "shard"
  end

  def menu_label
    ShardConfig.menu_label
  end

  def name_label
    ShardConfig.name_label
  end

  def tree_label
    ShardConfig.tree_label
  end

  def description_html
    ShardConfig.description_html
  end

  def tree_description_html
    ShardConfig.tree_description_html
  end

  def name_description_html
    ShardConfig.name_description_html
  end

  def tree_banner_text
    ShardConfig.tree_banner_text
  end

  def tree_label_text
    ShardConfig.tree_banner_text
  end

  def banner_text
    ShardConfig.banner_text
  end

  def page_title
    ShardConfig.page_title
  end

  def services_path_name_element
    ShardConfig.services_path_name_element
  end

  def services_path_tree_element
    ShardConfig.services_path_tree_element
  end

  def tree_search_help_text_html
    ShardConfig.tree_search_help_text_html
  end

  def name_search_help_text_html
    ShardConfig.name_search_help_text_html
  end

  def name_services(name_id)
    "#{Rails.configuration.services}#{Rails.configuration.services_path}/name/#{services_path_name_element}/#{name_id}"
  end

  def services_with_path
    "#{Rails.configuration.services}#{Rails.configuration.services_path}"
  end
end
