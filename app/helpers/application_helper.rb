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
end
