module Gorilla
  module Middleware
    class ApiVersion < Faraday::Middleware

      VERSION_HEADER = 'application/vnd.gorilla.v%s+json'.freeze

      def initialize(app, version)
        super(app)
        @version = version
      end

      def call(env)
        env[:request_headers]['Accept'] = accept_header
        @app.call(env)
      end

      private

      def accept_header
        VERSION_HEADER % @version
      end
    end
  end
end
