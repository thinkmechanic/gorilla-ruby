module Gorilla
  class Client < VanillaClient

    def initialize(opts={}, &block)
      super(opts) do |conn, options|
        conn.request :api_version, options[:version]
        conn.request :signature_auth, options
        yield(conn) if block_given?
      end
    end
  end
end
