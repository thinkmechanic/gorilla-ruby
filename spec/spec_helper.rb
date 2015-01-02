require 'bundler/setup'
Bundler.setup

require 'gorilla-io'

# Requires supporting ruby files
Dir["spec/support/**/*.rb"].each { |f| require File.expand_path("./#{f}") }

RSpec.configure do |config|
  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.order = :random
  Kernel.srand config.seed

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end

  # Example groups
  config.alias_example_group_to :describe_request_middleware, type: :request
  config.alias_example_group_to :describe_response_middleware, type: :response

  config.include FaradayHelpers
  config.include RequestMiddlewareContext, type: :request
  config.include ResponseMiddlewareContext, type: :response
end
