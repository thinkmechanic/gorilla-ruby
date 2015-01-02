module Gorilla
  # Top-level error for rescuing all Gorilla Client errors
  class Error < StandardError
    def initialize(response)
      @response = response
    end
  end

  # Raised when Gorilla.io returns the HTTP status code 400
  class BadRequest < Error; end

  # Raised when Gorilla.io returns the HTTP status code 401
  class Unauthorized < Error; end

  # Raised when Gorilla.io returns the HTTP status code 404
  class NotFound < Error; end

  # Raised when Gorilla.io returns the HTTP status code 422
  class ValidationError < Error; end

  # Raised when Gorilla.io returns the HTTP status code 50x
  class ServerError < Error; end
end
