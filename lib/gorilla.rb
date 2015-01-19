require 'faraday'
require 'faraday_middleware'
require 'configurations'
require 'jwt'

require 'gorilla/version'

require 'gorilla/error'
require 'gorilla/middleware/api_version'
require 'gorilla/middleware/user_agent'
require 'gorilla/middleware/signature_auth'
require 'gorilla/middleware/http_exceptions'

require 'gorilla/vanilla_client'
require 'gorilla/client'

module Gorilla
  include Configurations

  configurable api: %i{url version key secret token_duration}
  configurable :user_agent
  configurable :client_adapter

  configuration_defaults do |c|
    c.api.url = 'https://api.gorilla.io/'
    c.api.version = 1
    c.api.key = ENV['GORILLA_API_KEY']
    c.api.secret = ENV['GORILLA_API_SECRET']
    c.api.token_duration = 5 * 60

    c.user_agent = "Gorilla Client/#{VERSION}"
    c.client_adapter = Faraday.default_adapter
  end

  def self.testing!
    configure do |c|
      c.client_adapter = Faraday::Adapter::Test::Stubs.new
    end
  end

  Faraday::Request.register_middleware \
    user_agent: Gorilla::Middleware::UserAgent,
    api_version: Gorilla::Middleware::ApiVersion,
    signature_auth: Gorilla::Middleware::SignatureAuth

  Faraday::Response.register_middleware \
    http_exceptions: Gorilla::Middleware::HttpExceptions
end
