# frozen_string_literal: true

# Work out the timeout for a search request.
class TimeoutCalculator
  BASE = 40
  BASE_IF_NAME_BLANK = 140
  BASE_FOR_A_COUNT = 20
  DETAIL_COEFF = 0.045
  LIST_COEFF = 0.01
  DEFAULT_LIMIT = 100

  def initialize(options)
    throw 'Need limit to calculate timeout' unless options.key?(:limit)
    throw 'Need details flag to calculate timeout' unless options.key?(:details)
    @limit = options[:limit]
    @details = options[:details]
    @name_blank = options[:name_blank] || false
  end

  def timeout
    cbase = @name_blank ? BASE_IF_NAME_BLANK : BASE
    coeff = @details ? DETAIL_COEFF : LIST_COEFF
    limit = (@limit - DEFAULT_LIMIT) >= 0 ? (@limit - DEFAULT_LIMIT) : 1
    t = cbase + (limit * coeff)
    Rails.logger.info("BASE: #{cbase}; coeff: #{coeff}; \
                      limit: #{limit}; timeout: #{t}")
    t.round
  end
end
