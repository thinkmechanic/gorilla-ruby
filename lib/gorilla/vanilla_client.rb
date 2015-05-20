module Gorilla
  class VanillaClient

    attr_reader :connection

    def initialize(opts={}, &block)
      options = config.api.to_h.merge(opts)

      @connection = Faraday.new(options[:url]) do |conn|
        conn.request :multipart
        conn.request :user_agent, config.user_agent
        conn.request :url_encoded
        yield(conn, options) if block_given?
        conn.response :json, content_type: /\bjson$/
        conn.adapter *config.client_adapter
      end
    end

    def get(path, params={})
      request(:get, path, params)
    end

    def post(path, params={})
      request(:post, path, params)
    end

    def put(path, params={})
      request(:put, path, params)
    end

    def delete(path, params={})
      request(:delete, path, params)
    end

    def config
      Gorilla.configuration
    end

    private

    def request(method, path, params={})
      response = connection.send(method, path, params)
      Response.new(response)
    end
  end
end
