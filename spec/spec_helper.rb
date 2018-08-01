require 'rspec/its'
require 'spec_helper'
require 'gman_client'
require 'httparty'
require 'securerandom'
require 'simplecov'
require 'webmock/rspec'

SimpleCov.start

Dir[File.join(GmanClient.root, 'spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.order = :random
end
