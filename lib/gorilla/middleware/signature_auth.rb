module Gorilla
  module Middleware
    class SignatureAuth < Faraday::Middleware

      SIGNATURE_METHOD = 'Signature'.freeze
      SIGNATURE_ALGO = 'HS256'.freeze

      def initialize(app, opts={})
        [:key, :secret].each do |key|
          raise ArgumentError, "#{key.inspect} is required" if !opts[key]
        end

        unless opts[:token_duration]
          opts[:token_duration] = 5 * 60
        end

        super(app)
        @opts = opts
      end

      def call(env)
        env[:request_headers]['Authorization'] = build_auth_header(env)
        @app.call(env)
      end

      private

      def build_auth_header(env)
        token = build_token(env)
        "#{SIGNATURE_METHOD} #{@opts[:key]} #{token}"
      end

      def build_token(env)
        JWT.encode({
          exp: Time.now.utc.to_i + @opts[:token_duration].to_i,
          method: env[:method].to_s.upcase,
          path: env[:url].path.split('?').first
        }, @opts[:secret], SIGNATURE_ALGO)
      end
    end
  end
end
