module Gorilla
  module Middleware
    class HttpExceptions < Faraday::Middleware

      def call(env)
        @app.call(env).on_complete do |response|
          case response[:status].to_s.strip
          when '400'
            raise_error Gorilla::BadRequest, response
          when '401'
            raise_error Gorilla::Unauthorized, response
          when '404'
            raise_error Gorilla::NotFound, response
          when '422'
            raise_error Gorilla::ValidationError, response
          when /50\d/
            raise_error Gorilla::ServerError, response
          end
        end
      end

      private

      def raise_error(klass, response)
        msg = if response[:body].kind_of?(Hash)
          error = response[:body]['error']
          error['code'] + ' - ' + error['message']
        else
          response[:body]
        end

        raise klass.new(response), [response[:status], msg].compact.join(': ')
      end
    end
  end
end
