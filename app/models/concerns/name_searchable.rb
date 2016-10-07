# frozen_string_literal: true

# Concern for name Searching
# Extracted from name.rb
module NameSearchable
  extend ActiveSupport::Concern

  # Class methods
  module ClassMethods
    def search_for(string)
      where("( lower(name.simple_name) like ?
             or lower(name.simple_name) like ?
             or lower(f_unaccent(name.full_name)) like ?
             or lower(f_unaccent(name.full_name)) like ?)",
            string.downcase.tr("*", "%").tr("×", "x"),
            Name.string_for_possible_hybrids(string),
            string.downcase.tr("*", "%").tr("×", "x"),
            Name.string_for_possible_hybrids(string))
    end

    def simple_name_allow_for_hybrids_like(string)
      where("( lower(name.simple_name) like ?
            or lower(name.simple_name) like ?)",
            string.downcase.tr("*", "%").tr("×", "x"),
            Name.string_for_possible_hybrids(string))
    end

    def full_name_allow_for_hybrids_like(string)
      where("( lower(f_unaccent(name.full_name)) like ?
        or lower(f_unaccent(name.full_name)) like ?)",
            string.downcase.tr("*", "%").tr("×", "x"),
            Name.string_for_possible_hybrids(string))
    end

    def scientific_search
      Name.not_a_duplicate
          .has_an_instance
          .includes(:status)
          .includes(:rank)
    end

    def cultivar_search
      Name.not_a_duplicate
          .has_an_instance
          .includes(:status)
          .joins(:rank)
    end

    def common_search
      Name.not_a_duplicate
          .has_an_instance
          .includes(:status)
          .order("sort_name")
    end
  end
end
