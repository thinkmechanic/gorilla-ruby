module Gorilla
  class Client
    def connection
      @connection ||= Faraday.new(config.api_url) do |conn|
        conn.request :user_agent
        conn.request :api_version, config.api_version
        conn.request :json
        conn.request :signature_auth, {
          key: config.api_key,
          secret: config.api_secret,
          token_duration: config.token_duration
        }

        conn.response :json, content_type: /\bjson$/
        conn.response :http_exceptions

        conn.adapter Faraday.default_adapter
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

    private

    def config
      Gorilla.configuration
    end
  end
end
