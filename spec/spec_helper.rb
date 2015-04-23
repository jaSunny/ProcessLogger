require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rails_helper'
require 'database_cleaner'

ENV["RAILS_ENV"] ||= 'test'

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller

  config.expect_with :rspec do |expectations|

    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
    config.before(:all) do
	DatabaseCleaner.strategy = :truncation
	# DatabaseCleaner.clean
	DatabaseCleaner.clean_with(:truncation)
    end
    config.before(:each) do
	DatabaseCleaner.start
    end
    config.after(:each) do
	DatabaseCleaner.clean
    end
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

end
