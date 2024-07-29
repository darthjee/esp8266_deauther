# frozen_string_literal: true

lib = File.expand_path('../../source', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'simplecov'
SimpleCov.start 'rails'

require 'pry-nav'
require 'font_helper'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.filter_run_when_matching :focus
end

RSpec::Matchers.define_negated_matcher :not_raise_error, :raise_error
RSpec::Matchers.define_negated_matcher :not_change, :change
