require 'spec_helper'

RSpec.describe_request_middleware Gorilla::Middleware::SignatureAuth do
  let(:api_key) { 'api-key' }
  let(:api_secret) { 'api-secret' }
  let(:token_duration) { 5 * 60 }

  let(:args) { [{
    key: api_key,
    secret: api_secret,
    token_duration: token_duration
  }] }

  let(:test_time) { Time.mktime(2015, 1, 1) }
  before { allow(Time).to receive(:now).and_return(test_time) }

  let(:token) do
    JWT.encode({
      exp: test_time.utc.to_i + token_duration.to_i,
      method: 'GET',
      path: '/forms'
    }, api_secret, 'HS256')
  end

  let(:result) do
    process(nil) do |env|
      env[:method] = :get
      env[:url] = URI.parse('https://api.gorilla.io/forms')
    end
  end

  context 'missing an :api_key' do
    let(:api_key) { nil }

    it 'raises an ArgumentError' do
      expect { result }.to raise_error(ArgumentError, ':key is required')
    end
  end

  context 'missing an :api_secret' do
    let(:api_secret) { nil }

    it 'raises an ArgumentError' do
      expect { result }.to raise_error(ArgumentError, ':secret is required')
    end
  end

  context 'with valid credentials' do
    it 'sets the Authorization header' do
      auth = result[:request_headers]['authorization']
      expect(auth).to eq("Signature #{api_key} #{token}")
    end
  end
end
