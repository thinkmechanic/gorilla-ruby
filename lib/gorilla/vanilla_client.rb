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
      response = connection.get(path, params)
      Response.new(response)
    end

    def post(path, params={})
      response = connection.post(path, params)
      Response.new(response)
    end

    def put(path, params={})
      response = connection.put(path, params)
      Response.new(response)
    end

    def delete(path, params={})
      response = connection.delete(path, params)
      Response.new(response)
    end

    def config
      Gorilla.configuration
    end
  end
end
