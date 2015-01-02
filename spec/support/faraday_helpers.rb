module FaradayHelpers
  def faraday_env(env)
    Faraday::Env.from(env)
  end
end

module RequestMiddlewareContext
  def self.included(base)
    base.let(:args) { [] }
    base.let(:middleware) do
      described_class.new(lambda{|env| env}, *args)
    end
  end

  def process(body, &block)
    env = {
      body: body,
      request_headers: Faraday::Utils::Headers.new
    }

    yield env if block_given?
    middleware.call(faraday_env(env))
  end
end

module ResponseMiddlewareContext
  def self.included(base)
    base.let(:args) { [] }
    base.let(:headers) { Hash.new }
    base.let(:middleware) {
      described_class.new(lambda {|env|
        Faraday::Response.new(env)
      }, *args)
    }
  end

  def process(body, status, options = {})
    env = {
      body: body,
      status: status,
      request: options,
      request_headers: Faraday::Utils::Headers.new,
      response_headers: Faraday::Utils::Headers.new(headers)
    }

    yield env if block_given?
    middleware.call(faraday_env(env))
  end
end
