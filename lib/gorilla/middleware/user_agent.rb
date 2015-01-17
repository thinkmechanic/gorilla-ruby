module Gorilla
  module Middleware
    class UserAgent < Faraday::Middleware
      def initialize(app, agent_string)
        super(app)
        @agent_string = agent_string
      end

      def call(env)
        env[:request_headers]['User-Agent'] = @agent_string
        @app.call(env)
      end
    end
  end
end
