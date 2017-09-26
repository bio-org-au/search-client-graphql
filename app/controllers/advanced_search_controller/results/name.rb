# frozen_string_literal: true

# Container for names in results
class AdvancedSearchController::Results::Name
  def initialize(raw_name)
    @raw_name = raw_name
  end

  def full_name
    @raw_name.full_name
  end

  def name_status_name
    return nil if @raw_name.name_status_name.nil? ||
                  @raw_name.name_status_name == 'legitimate' ||
                  @raw_name.name_status_name.match(/\[/)
    @raw_name.name_status_name
  end

  def usages
    @raw_name.name_history.name_usages.collect do |usage|
      SearchController::Results::Name::Usage.new(usage)
    end
  end

  def family_name
    @raw_name.family_name
  end
end
