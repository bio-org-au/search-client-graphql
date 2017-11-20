# frozen_string_literal: true

# General view helpers.
module ApplicationHelper
  def env_tag
    case Rails.configuration.try('environment')
    when /^dev/i then 'Dev'
    when /^test/i then 'Test'
    when /^stag/i then 'Stage'
    when /^prod/i then ''
    else
      'Unknown'
    end
  end

  def development?
    Rails.configuration.try('environment').match(/^development/i)
  end
end
