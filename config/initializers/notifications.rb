

# frozen_string_literal: true

require 'nunes'
statsd = Statsd.new('127.0.0.1', 8125)
Nunes.subscribe(statsd)
