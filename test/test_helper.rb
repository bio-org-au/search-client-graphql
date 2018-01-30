# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
# require 'minitest/autorun'
require 'mocha'
require 'mocha/setup'
require 'mocha/mini_test'

# Set up for all tests.
class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical
  # order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

def stub_rank_options
  Rank.any_instance
      .stubs(:options)
      .returns(['regio', 'reg.', 'div.', 'cl.', 'subcl.', 'superordo', 'ordo',
                'subordo', 'fam.', 'subfam.', 'trib.', 'subtrib.', 'gen.',
                'subg.', 'sect.', 'subsect.', 'ser.', 'subser.', 'supersp.',
                'sp.', 'subsp.', 'var.', 'nothovar.', 'subvar.', 'f.', 'subf.',
                '[n/a]', '[infrafamily]', '[infragenus]', '[unranked]',
                '[infrasp.]'])
end
