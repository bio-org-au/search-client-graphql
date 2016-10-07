# frozen_string_literal: true

# Concern for displaying names
# Extracted from name.rb
module NameJsonable
  extend ActiveSupport::Concern

  def as_json(options = {})
    logger.debug("as_json options: #{options}")
    [name: full_name, status: status.name]
  end
end
