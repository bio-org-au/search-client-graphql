# frozen_string_literal: true

# Class extracted from name controller.
class NameCheckController::Results::CheckedName
  def initialize(checked_name)
    @checked_name = checked_name
  end

  def matched_name_id
    @checked_name.matched_name_id
  end

  def matched_name_full_name
    @checked_name.matched_name_full_name
  end

  def matched_name_family_name
    @checked_name.matched_name_family_name
  end

  def matched_name_family_name_id
    @checked_name.matched_name_family_name_id
  end

  def search_term
    @checked_name.search_term
  end

  def index
    @checked_name.index
  end

  def found?
    @checked_name.found == 't' || @checked_name.found
  end
end
