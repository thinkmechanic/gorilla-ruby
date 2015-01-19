module Gorilla
  class Response

    attr_reader :response

    def initialize(response)
      @response = response
    end

    def body
      response.body
    end

    def status
      response.status
    end

    def success?
      !error?
    end

    def error?
      body[:error] != nil
    end

    def error
      body[:error]
    end
  end
end
