# frozen_string_literal: true

# Work out the timeout for a search request.
class NameCheckController::Index::ClientRequest::TimeoutCalculator
  DEFAULT_BASE = 20
  LIST_COEFF = 1.0

  def initialize(client_request)
    @client_request = client_request
  end

  def choose_base
    DEFAULT_BASE
  end

  def limit
    @client_request.limit
  end

  def timeout
    chosen_base = choose_base
    coeff = LIST_COEFF
    # size = @client_request.names_as_array_of_strings.size
    t = chosen_base + (limit * coeff)
    Rails.logger.info("Base: #{chosen_base}; coeff: #{coeff}; \
                      limit: #{limit}; timeout: #{t}")
    t.round
  end
end
