require 'factory_bot_rails'
require File.expand_path("../../config/environment",__FILE__)
require 'rspec/rails'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:each, type: :system) do
    driven_by :selenium_chrome_headless
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
