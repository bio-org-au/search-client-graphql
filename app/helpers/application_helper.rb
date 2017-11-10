# frozen_string_literal: true

# General view helpers.
module ApplicationHelper
  def env_tag
    case Rails.configuration.try('environment')
    when /^dev/i
      'Dev'
    when /^test/i
      'Test'
    when /^stag/i
      'Stage'
    when /^prod/i
      ''
    else
      'Unknown'
    end
  end

  def development?
    Rails.configuration.try('environment').match(/^development/i)
  end
end
