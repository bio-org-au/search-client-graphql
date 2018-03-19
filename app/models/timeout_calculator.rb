# frozen_string_literal: true

# Work out the timeout for a search request.
class TimeoutCalculator
  DEFAULT_BASE = 100
  BASE_IF_NAME_BLANK = 240
  BASE_FOR_A_COUNT = 20
  DETAIL_COEFF = 0.045
  LIST_COEFF = 0.01
  DEFAULT_LIMIT = 200

  def initialize(client_request)
    @client_request = client_request
  end

  def choose_base
    if @client_request.just_count?
      BASE_FOR_A_COUNT
    elsif @client_request.search_term.blank?
      BASE_IF_NAME_BLANK
    else
      DEFAULT_BASE
    end
  end

  def choose_limit
    if @client_request.limit.to_i - DEFAULT_LIMIT >= 0
      @client_request.limit.to_i - DEFAULT_LIMIT
    else
      1
    end
  end

  def timeout
    chosen_base = choose_base
    coeff = @client_request.details? ? DETAIL_COEFF : LIST_COEFF
    limit = choose_limit
    t = chosen_base + (limit * coeff)
    Rails.logger.info("Base: #{chosen_base}; coeff: #{coeff}; \
                      limit: #{limit}; timeout: #{t}")
    t.round
  end
end
