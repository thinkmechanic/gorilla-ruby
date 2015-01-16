require 'faraday'
require 'faraday_middleware'
require 'configurations'
require 'jwt'

require 'gorilla/error'
require 'gorilla/middleware/api_version'
require 'gorilla/middleware/user_agent'
require 'gorilla/middleware/signature_auth'
require 'gorilla/middleware/http_exceptions'
require 'gorilla/client'
require 'gorilla/version'

module Gorilla
  include Configurations

  configurable :api_version, :api_url, :api_key, :api_secret
  configurable :token_duration

  configuration_defaults do |c|
    c.api_key = nil
    c.api_secret = nil
    c.api_version = 1
    c.api_url = 'https://api.gorilla.io/'
    c.token_duration = 5 * 60
  end

  Faraday::Request.register_middleware \
    user_agent: Gorilla::Middleware::UserAgent,
    api_version: Gorilla::Middleware::ApiVersion,
    signature_auth: Gorilla::Middleware::SignatureAuth

  Faraday::Response.register_middleware \
    http_exceptions: Gorilla::Middleware::HttpExceptions
end
