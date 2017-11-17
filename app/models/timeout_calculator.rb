# frozen_string_literal: true

class TimeoutCalculator
  BASE = 10
  DETAIL_COEFF = 0.045
  LIST_COEFF = 0.01
  DEFAULT_LIMIT = 100

  def initialize(options)
    throw "Need limit to calculate timeout" unless options.has_key?(:limit)
    throw "Need details boolean to calculate timeout" unless options.has_key?(:details)
    @limit = options[:limit]
    @details = options[:details]
  end

  def timeout
    coeff = @details ? DETAIL_COEFF : LIST_COEFF
    limit = (@limit - DEFAULT_LIMIT) >= 0 ? (@limit - DEFAULT_LIMIT) : 1
    t = BASE + (limit * coeff)
    Rails.logger.info("BASE: #{BASE}; coeff: #{coeff}; limit: #{limit}; timeout: #{t}")
    t.round
  end
end

