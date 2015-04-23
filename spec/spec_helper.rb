require 'database_cleaner'
require 'coveralls'
Coveralls.wear!

RSpec.configure do |config|
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
