# frozen_string_literal: true

# Container for publications in results
class Application::Publications::Results::Publication
  def initialize(raw_publication)
    @raw = raw_publication
  end

  def id
    @raw.id
  end

  def citation
    @raw.citation
  end

  def citation_html
    @raw.citation_html
  end
end
