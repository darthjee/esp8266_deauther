# frozen_string_literal: true

require 'simplecov'
SimpleCov.start 'rails'

require 'pry-nav'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.filter_run_when_matching :focus
end

RSpec::Matchers.define_negated_matcher :not_raise_error, :raise_error
RSpec::Matchers.define_negated_matcher :not_change, :change
