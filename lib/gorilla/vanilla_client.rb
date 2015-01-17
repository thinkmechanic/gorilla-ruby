module Gorilla
  class VanillaClient

    attr_reader :connection

    def initialize(opts={}, &block)
      options = config.api.to_h.merge(opts)

      @connection = Faraday.new(options[:url]) do |conn|
        conn.request :user_agent, config.user_agent
        conn.request :json
        yield(conn, options) if block_given?
        conn.response :json, content_type: /\bjson$/
        conn.adapter config.client_adapter
      end
    end

    def get(path, params={})
      connection.get(path, params)
    end

    def post(path, params={})
      connection.post(path, params)
    end

    def put(path, params={})
      connection.put(path, params)
    end

    def delete(path, params={})
      connection.delete(path, params)
    end

    def config
      Gorilla.configuration
    end
  end
end
