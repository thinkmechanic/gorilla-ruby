module Gorilla
  module Middleware
    class UserAgent < Faraday::Middleware

      AGENT_HEADER = 'Gorilla Ruby Client/%s'.freeze

      def call(env)
        env[:request_headers]['User-Agent'] = agent_header
        @app.call(env)
      end

      private

      def agent_header
        AGENT_HEADER % Gorilla::VERSION
      end
    end
  end
end
