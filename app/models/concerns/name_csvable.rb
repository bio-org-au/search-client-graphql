# frozen_string_literal: true

# Concern for displaying names
# Extracted from name.rb
module NameCsvable
  extend ActiveSupport::Concern

  def to_csv
    attributes.values_at(*Name.columns.map(&:name))
    [full_name, status.name].to_csv
  end

  # Class methods
  module ClassMethods
    def csv_headings
      %w(full_name status).to_csv
    end
  end
end
