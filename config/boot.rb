# frozen_string_literal: true

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

# make the ExecJs use NodeJs
ENV['EXECJS_RUNTIME'] = 'Node'
