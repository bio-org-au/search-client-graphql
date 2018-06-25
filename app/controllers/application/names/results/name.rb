# frozen_string_literal: true

# Container for names in results
class Application::Names::Results::Name
  def initialize(raw_name)
    @raw_name = raw_name
  end

  def full_name
    @raw_name.full_name
  end

  def name_status_name
    return nil if @raw_name.name_status_name.nil? ||
                  @raw_name.name_status_is_displayed == false
    @raw_name.name_status_name
  end

  def name_usages
    if @raw_name.name_usages.nil?
      Rails.logger.error('@raw_name.name_usages is nil')
      []
    else
      @raw_name.name_usages.collect do |raw_name_usage|
        Application::Names::Results::Name::Usage.new(raw_name_usage)
      end
    end
  end

  def family_name
    @raw_name.family_name
  end

  def id
    @raw_name.id
  end
end
